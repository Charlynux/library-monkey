(ns library-monkey.core
  (:gen-class)
  (:require
   [library-monkey.configuration :as config]
   [library-monkey.network :as net]
   [library-monkey.html-parse :as parse]
   [library-monkey.console :as console]
   [clojure.spec.alpha :as s]
   [cognitect.anomalies :as anom]
   [clojure.core.async :as a :refer [<!! <! go chan]]))

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

(defn aggregate-reports [ch]
  (<!! (a/transduce (map identity)
                    (fn
                      ([result] result)
                      ([acc report]
                       (-> acc
                           (update :count
                                   +
                                   (count (:borrowings report)))
                           (update :reports conj report))))
                    { :count 0 :reports [] }
                    ch)))

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

(defn -main
  [config-file & args]
  (let [config (clojure.edn/read-string (slurp config-file))]
    (if (not (s/valid? ::config/config config))
      (do
        (println "Erreur dans le format du fichier `config.edn`")
        (s/explain ::config/config config)
        (flush)
        (System/exit 1))
      (let [reports-ch (chan 4)
            reader (generate-reports amiens-library (:accounts config) reports-ch)
            reports (aggregate-reports reports-ch)]
        (println (format "Total : %d document(s)" (:count reports)))
        (doseq [report (:reports reports)]
          (console/print-report report))))))
