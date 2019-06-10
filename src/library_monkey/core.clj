(ns library-monkey.core
  (:gen-class)
  (:require [library-monkey.network :as net]
            [library-monkey.html-parse :as parse]
            [cognitect.anomalies :as anom]))

(def get-borrowings (comp parse/extract-borrowings net/get-borrowings))

(defn -main
  [user password & args]
  (let [cookie (net/auth-cookie user password)]
    (println "Rapport pour carte : " user)
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
