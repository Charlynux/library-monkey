(require '[library-monkey.core :as lm]
         '[datascript.core :as d])

(def configuration (clojure.edn/read-string (slurp "config.edn")))

(def conn (d/create-conn lm/schema))

(lm/read-all-accounts configuration conn)

(def query-utilisateurs-avec-emprunt
  '[:find ?pseudo
    :where
    [?u :pseudo ?pseudo]
    [?u :borrowings ?b]])

(def query-tous-utilisateurs
  '[:find ?pseudo
    :where
    [?u :pseudo ?pseudo]])

(d/q query-utilisateurs-avec-emprunt @conn)
(d/q query-tous-utilisateurs @conn)

(sort-by (juxt first second)
         (d/q
          '[:find ?pseudo ?type (count ?b)
            :where
            [?u :pseudo ?pseudo]
            [?u :borrowings ?b]
            [?b :type-de-document ?type]]
          @conn))
