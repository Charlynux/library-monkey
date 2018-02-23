(ns library-monkey.core
    (:gen-class)
    (:require [library-monkey.network :as net]
      [library-monkey.html-parse :as parse]))
  
  (defn -main
    [user password & args]
    (->> 
      (net/auth-cookie user password)
      (net/get-borrowings)
      (parse/extract-borrowings)
      (#(doseq [b %] (println (:titre b) (:date-de-retour b))))))
  