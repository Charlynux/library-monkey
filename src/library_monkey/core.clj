(ns library-monkey.core
  (:gen-class)
  (:require
   [library-monkey.network :as net]
   [library-monkey.html-parse :as parse]
   [clojure.spec.alpha :as s]
   [cognitect.anomalies :as anom]))

(s/def ::credentials (s/+ (s/cat :username string? :password string?)))

(def get-borrowings (comp parse/extract-borrowings net/get-borrowings))

(defn manage-user [{:keys [username password]}]
  (let [cookie (net/auth-cookie username password)]
    (println "Rapport pour carte : " username)
    (when (::anom/category cookie)
      (do
        (println "Erreur lors de l'authenfication : " (::anom/category cookie))
        (System/exit -1)))
    (println "Authentification OK")
    (->> cookie
         get-borrowings
         (map (comp (partial net/renew cookie) :code-barre))
         doall)
    (println "Prolongation des emprunts effectuée")
    (->> cookie
         get-borrowings
         (map #(println (:titre %) (:date-de-retour %)))
         doall)))

(defn -main
  [& args]
  (let [credentials (s/conform ::credentials args)]
    (if (s/invalid? credentials)
      (do
        (println "Erreur dans les paramètres")
        (s/explain ::credentials args)
        (flush)
        (System/exit 1))
      (doall (map manage-user credentials)))))
