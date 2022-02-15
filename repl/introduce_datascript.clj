(require '[library-monkey.core :as lm]
         '[datascript.core :as d])

(def configuration (clojure.edn/read-string (slurp "config.edn")))

(def schema {:username {:db/unique :db.unique/identity}
             :user {:db/valueType :db.type/ref}})
(def conn (d/create-conn schema))

(let [library lm/amiens-library]
  (doseq [user (:accounts configuration)]
    (d/transact! conn [user])
    (let [cookie (authenticate library
                               (:username user)
                               (:password user))]
      (d/transact! conn
                   (map
                    (fn [borrowing] (assoc borrowing :user user))
                    (get-borrowings library cookie))))))

(def query-utilisateurs-avec-emprunt
  '[:find ?pseudo
    :where
    [?e :user ?u]
    [?u :pseudo ?pseudo]])

(def query-tous-utilisateurs
  '[:find ?pseudo
    :where
    [?u :pseudo ?pseudo]])

(d/q query-utilisateurs-avec-emprunt @conn)
(d/q query-tous-utilisateurs @conn)
