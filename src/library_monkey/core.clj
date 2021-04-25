(ns library-monkey.core
  (:gen-class)
  (:require
   [clojure.pprint :as pprint]
   [library-monkey.network :as net]
   [library-monkey.html-parse :as parse]
   [clojure.spec.alpha :as s]
   [cognitect.anomalies :as anom]
   [clojure.core.async :as a :refer [<!! <! go chan]]))

(s/def ::credentials (s/+ (s/cat :username string? :password string?)))

(def discard-chan (chan 10))

(defn dot [] (map (fn [v] (print ".") (flush) v)))

(defprotocol Library
  (authenticate [this username password])
  (get-borrowings [this identity])
  (renew-borrowing! [this identity borrowing]))

(defn renew-all-borrowings [library cookie]
  (<!!
   (a/pipeline-blocking
    10
    discard-chan
    (comp (map #(renew-borrowing! library cookie %)) (dot))
    (a/to-chan (get-borrowings library cookie)))))

(defn manage-user [library {:keys [username password] :as creds }]
  (let [cookie (authenticate library username password)]
    (if (::anom/category cookie)
      (assoc creds :credentials-error (::anom/category cookie))
      (do
        (renew-all-borrowings library cookie)
        (assoc creds :borrowings (get-borrowings library cookie))))))

(defn print-report [report]
  (println (format "Carte %s - %d document(s)"
                   (:username report)
                   (count (:borrowings report))))
  (if-let [cred-error (:credentials-error report)]
    (println "Erreur lors de l'authenfication : " cred-error)
    (if (empty? (:borrowings report))
      (println "** Aucun document pour cette carte **")
      (pprint/print-table
       [:titre :date-de-retour]
       ;; FIXME : Convert date-de-retour into date for sorting
       (:borrowings report))))
  (println))

(comment
  (print-report
   {:username "123456789"
    :borrowings
    [{:titre "Un titre un peu long" :date-de-retour "03/04/2021"}
     {:titre "Ippo" :date-de-retour "21/03/2021"}
     {:titre "Ippo" :date-de-retour "21/03/2021"}
     {:titre "Asterix" :date-de-retour "03/04/2021"}]})

  (print-report
   {:username "123456789"
    :borrowings
    []})
  )

(defn generate-reports [library credentials]
  (let [reports (chan 4)]
    (a/pipeline-blocking
     4
     reports
     (map #(manage-user library %))
     (a/to-chan credentials))
    (<!! (a/transduce (map identity)
                      (fn
                        ([result] result)
                        ([acc report]
                         (-> acc
                             (update :count
                                     +
                                     (count (:borrowings report)))
                             (update :reports conj report))))
                      { :count 0 :reports [] } reports))))

(def amiens-library
  (reify Library
    (authenticate [this username password]
      (net/auth-cookie username password))
    (get-borrowings [this identity]
      (parse/extract-borrowings (net/get-borrowings identity)))
    (renew-borrowing! [this identity borrowing]
      (net/renew identity (:code-barre borrowing)))))

(defn -main
  [& args]
  (let [credentials (s/conform ::credentials args)]
    (if (s/invalid? credentials)
      (do
        (println "Erreur dans les paramètres")
        (s/explain ::credentials args)
        (flush)
        (System/exit 1))
      (let [reports (generate-reports amiens-library credentials)]
        (println) ;; Newline after dots.
        (println (format "Total : %d document(s)" (:count reports)))
        (doseq [report (:reports reports)]
          (print-report report))))))
