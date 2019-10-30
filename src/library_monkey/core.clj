(ns library-monkey.core
  (:gen-class)
  (:require
   [library-monkey.network :as net]
   [library-monkey.html-parse :as parse]
   [clojure.spec.alpha :as s]
   [cognitect.anomalies :as anom]))

(s/def ::credentials (s/+ (s/cat :username string? :password string?)))

(def get-borrowings (comp parse/extract-borrowings net/get-borrowings))

(defn proceed [cookie]
  (->> cookie
       get-borrowings
       (map :code-barre)
       (map (partial net/renew cookie))
       doall)
  (get-borrowings cookie))

(defn manage-user [{:keys [username password] :as creds }]
  (let [cookie (net/auth-cookie username password)]
    (if (::anom/category cookie)
      (assoc creds :credentials-error (::anom/category cookie))
      (assoc creds :borrowings (proceed cookie)))))

(defn print-report [report]
  (println "Rapport pour carte : " (:username report))
  (if-let [cred-error (:credentials-error report)]
    (println "Erreur lors de l'authenfication : " cred-error)
    (doseq [borrowing (:borrowings report)]
      (println (:titre borrowing) (:date-de-retour borrowing)))))

(defn -main
  [& args]
  (let [credentials (s/conform ::credentials args)]
    (if (s/invalid? credentials)
      (do
        (println "Erreur dans les paramètres")
        (s/explain ::credentials args)
        (flush)
        (System/exit 1))
      (->> credentials
           (map manage-user)
           (map print-report)
           doall))))
