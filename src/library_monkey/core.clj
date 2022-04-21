(ns library-monkey.core
  (:gen-class)
  (:require
   [library-monkey.configuration :as config]
   [library-monkey.network :as net]
   [library-monkey.html-parse :as parse]
   [library-monkey.console :as console]
   [clojure.spec.alpha :as s]
   [cognitect.anomalies :as anom]
   [clojure.core.async :as a :refer [<!! <! go chan]]
   [datascript.core :as d]))

(defprotocol Library
  (authenticate [this username password])
  (get-borrowings [this identity])
  (renew-borrowing! [this identity borrowing]))

(defn manage-user [library {:keys [username password] :as creds }]
  (let [cookie (authenticate library username password)]
    (if (::anom/category cookie)
      (assoc creds :credentials-error (::anom/category cookie))
      (assoc creds :borrowings (get-borrowings library cookie)))))

(defn generate-reports [library credentials ch]
  (a/pipeline-blocking
   4
   ch
   (map #(manage-user library %))
   (a/to-chan credentials)))

(defn load-database [conn ch]
  (let [output (chan 4)]
    (a/pipeline-blocking
     4
     output
     (map (fn [report] (d/transact! conn [report])))
     ch)
    (a/transduce
     (map identity)
     (completing (fn [acc _] (update acc :count inc)))
     {:count 0}
     output)))

(def schema {:username {:db/unique :db.unique/identity}
             :borrowings {:db/type :db.type/ref
                          :db/cardinality :db.cardinality/many}})
(comment

  (require '[clojure.spec.gen.alpha :as gen])
  (def conn (d/create-conn schema))

  (<!! (load-database
        conn
        (a/to-chan (gen/sample (s/gen ::console/report)))))
  (println)

  (d/q
   '[:find (count ?b)
     :where
     [?u :borrowings ?b]]
   @conn)

  (count (map first (d/q '[:find (pull ?r [:pseudo])
                      :where [?r :borrowings ?b]]
                         @conn))))

(defn read-aggregates [conn]
  (hash-map
   :count (or
           (d/q
              '[:find (count ?b) .
                :where
                [?u :borrowings ?b]]
              @conn)
           0)
   :reports (d/q '[:find [(pull ?r [:pseudo :username
                                    {:borrowings [:titre :date-de-retour :type-de-document]}]) ...]
                   :where [?r :borrowings ?b]]
                 @conn)))

(def amiens-library
  (reify Library
    (authenticate [this username password]
      (net/auth-cookie username password))
    (get-borrowings [this identity]
      (let [borrowings (net/get-borrowings identity)]
        (if (::anom/category borrowings)
          borrowings
          (parse/extract-borrowings borrowings))))
    (renew-borrowing! [this identity borrowing]
      (net/renew identity (:code-barre borrowing)))))

(defn read-all-accounts [config conn]
  (let [reports-ch (chan 4)
        reader (generate-reports amiens-library (:accounts config) reports-ch)
        writer (load-database conn reports-ch)]
    { :reader (<!! reader) :writer (<!! writer)}))

(defn -main
  [config-file & args]
  (let [config (clojure.edn/read-string (slurp config-file))]
    (if (not (s/valid? ::config/config config))
      (do
        (println "Erreur dans le format du fichier `config.edn`")
        (s/explain ::config/config config)
        (flush)
        (System/exit 1))
      (let [conn (d/create-conn schema)
            result (read-all-accounts config conn)
            reports (read-aggregates conn)]
        (println (format "Total : %d document(s)" (:count reports)))
        (doseq [report (:reports reports)]
          (console/print-report report))))))

(comment
  (-main "config.edn")
  )
