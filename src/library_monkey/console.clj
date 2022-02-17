(ns library-monkey.console
  (:require
   [library-monkey.configuration :as config]
   [clojure.spec.alpha :as s]
   [clojure.spec.gen.alpha :as gen]
   [cognitect.anomalies :as anom]
   [clojure.pprint :as pprint])
  (:import
   [java.time LocalDate]))

(s/def ::local-date (s/with-gen
                      #(instance? LocalDate %)
                      #(gen/fmap
                        (fn [[year month day]] (LocalDate/of year month day))
                        (gen/tuple (gen/choose 2000 2050)
                                   (gen/choose 1 12)
                                   (gen/choose 1 28)))))

(s/def ::titre (s/and string? #(not-empty %)))
(s/def ::date-de-retour ::local-date)
(s/def ::type-de-document #{"Livre" "Jeu"}) ;; A compléter lorsque d'autres types seront découverts
(s/def ::borrowing (s/keys :req-un [::titre ::date-de-retour ::type-de-document]))
(s/def ::borrowings (s/coll-of ::borrowing))
(s/def ::report (s/keys :req-un [:config/username ::borrowings] :opt-un [:config/pseudo]))

(defn ellipsis [s n]
  (if (< (count s) n)
    s
    (str
     (subs s 0 (- n 3))
     "...")))

(defn print-report [report]
  (let [borrowings (group-by :type-de-document (:borrowings report))]
    (println (format "Carte %s - %s"
                     (or (:pseudo report) (:username report))
                     (clojure.string/join
                      " | "
                      (map
                       (fn [[type docs]] (str (count docs) " " type))
                       borrowings))))
    (if-let [cred-error (:credentials-error report)]
      (println "Erreur lors de l'authenfication : " cred-error)
      (cond
        (empty? (:borrowings report))
        (println "** Aucun document pour cette carte **")

        (::anom/category (:borrowings report))
        (println (::anom/category (:borrowings report)))

        :else
        (doseq [[type docs] borrowings]
          (println (format "** %s **" type))
          (pprint/print-table
           [:titre :date-de-retour]
           (map
            (fn [doc] (update doc :titre #(ellipsis % 45)))
            docs))))))
  (println))

(s/fdef print-report
  :args (s/cat :report ::report))

(comment
  (s/exercise-fn `print-report)

  (require '[clojure.spec.test.alpha :as stest])
  (import java.time.LocalDate)

  (stest/instrument `print-report)

  (print-report
   {:username "123456789"
    :borrowings
    [{:titre "Un titre un peu long" :date-de-retour (LocalDate/parse "2021-04-03") :type-de-document "Livre"}
     {:titre "Un titre vraiment vraiment vraiment vraiment très long" :date-de-retour (LocalDate/parse "2021-04-03") :type-de-document "Livre"}
     {:titre "Ippo" :date-de-retour (LocalDate/parse "2021-03-21") :type-de-document "Livre"}
     {:titre "Ippo" :date-de-retour (LocalDate/parse "2021-03-21") :type-de-document "Livre"}
     {:titre "Asterix" :date-de-retour (LocalDate/parse "2021-04-03") :type-de-document "Livre"}
     {:titre "Six qui prend" :date-de-retour (LocalDate/parse "2021-04-03") :type-de-document "Jeu"}]})

  (print-report
   {:username "123456789"
    :borrowings
    []})
  )
