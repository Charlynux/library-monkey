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

(def emprunts-avec-date
  "Retourne les emprunts correspondants au prédicat `?check-date`
  sur la date de retour.

  Requête utilisée pour trouver les emprunts en retard."
  '[:find ?code ?titre ?date
    :in $ ?check-date
    :where
    [_ :borrowings ?b]
    [?b :titre ?titre]
    [?b :date-de-retour ?date]
    [?b :code-barre ?code]
    [(?check-date ?date)]])

(d/q
 emprunts-avec-date
 @conn
 (fn [date] (.isBefore date (java.time.LocalDate/now))))

(def nb-emprunts-par-delai
  "Retourne le nombre d'emprunts par délai de retour"
  '[:find ?delay (count ?code)
    :keys nb-jours documents
    :in $ ?calculate
    :where
    [_ :borrowings ?b]
    [?b :date-de-retour ?date]
    [?b :code-barre ?code]
    [(?calculate ?date) ?delay]])

(->> (d/q
      nb-emprunts-par-delai
      @conn
      (fn [date] (.between
                  java.time.temporal.ChronoUnit/DAYS
                  (java.time.LocalDate/now)
                  date)))
     (sort-by :nb-jours <)
     (clojure.pprint/print-table))

(d/q
 '[:find (count ?b) .
   :where
   [?u :borrowings ?b]]
 @conn)
