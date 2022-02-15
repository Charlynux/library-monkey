(require '[library-monkey.core :as lm]
         '[datascript.core :as d])

(def configuration (clojure.edn/read-string (slurp "config.edn")))

(def schema {:user {:db/cardinality :db.cardinality/one}})
(def conn (d/create-conn schema))

(let [library lm/amiens-library
      user (get-in configuration [:accounts 0])
      cookie (authenticate library
                           (:username user)
                           (:password user))]
  (d/transact! conn
               (map
                (fn [borrowing] (assoc borrowing :user user))
                (get-borrowings library cookie))))


(d/q '[:find ?title ?date
       :where
       [?e :titre ?title]
       [?e :date-de-retour ?date]] @conn)
