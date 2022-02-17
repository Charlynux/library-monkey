(ns library-monkey.core
  (:gen-class)
  (:require
   [clojure.pprint :as pprint]
   [library-monkey.network :as net]
   [library-monkey.html-parse :as parse]
   [clojure.spec.alpha :as s]
   [clojure.spec.gen.alpha :as gen]
   [cognitect.anomalies :as anom]
   [clojure.core.async :as a :refer [<!! <! go chan]]))

(s/def ::numeric-string (s/with-gen
                          (s/and string? #(re-matches #"\d+" %))
                          (fn [] (gen/fmap (comp str inc #(Math/abs %))
                                           (gen/int)))))
(s/def ::pseudo string?)
(s/def ::password ::numeric-string)
(s/def ::username ::numeric-string)
(s/def ::account (s/keys :req-un [::username ::password]
                         :opt-un [::pseudo]))
(s/def ::accounts (s/coll-of ::account))
(s/def ::config (s/keys :req-un [::accounts]))

(comment
  (s/explain-data ::account {:username "TOTO" :password "156"})
  )

(defprotocol Library
  (authenticate [this username password])
  (get-borrowings [this identity])
  (renew-borrowing! [this identity borrowing]))

(defn manage-user [library {:keys [username password] :as creds }]
  (let [cookie (authenticate library username password)]
    (if (::anom/category cookie)
      (assoc creds :credentials-error (::anom/category cookie))
      (assoc creds :borrowings (get-borrowings library cookie)))))

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
(s/def ::report (s/keys :req-un [::username ::borrowings] :opt-un [::pseudo]))

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

(defn generate-reports [library credentials ch]
  (a/pipeline-blocking
   4
   ch
   (map #(manage-user library %))
   (a/to-chan credentials)))

(defn aggregate-reports [ch]
  (<!! (a/transduce (map identity)
                    (fn
                      ([result] result)
                      ([acc report]
                       (-> acc
                           (update :count
                                   +
                                   (count (:borrowings report)))
                           (update :reports conj report))))
                    { :count 0 :reports [] }
                    ch)))

(def amiens-library
  (reify Library
    (authenticate [this username password]
      (net/auth-cookie username password))
    (get-borrowings [this identity]
      (let [borrowings (net/get-borrowings identity)]
        (if (::anom/category borrowings)
          borrowings
          (parse/extract-borrowings borrowings))))
    (renew-borrowing! [this identity borrowing]
      (net/renew identity (:code-barre borrowing)))))

(defn -main
  [config-file & args]
  (let [config (clojure.edn/read-string (slurp config-file))]
    (if (not (s/valid? ::config config))
      (do
        (println "Erreur dans le format du fichier `config.edn`")
        (s/explain ::config config)
        (flush)
        (System/exit 1))
      (let [reports-ch (chan 4)
            reader (generate-reports amiens-library (:accounts config) reports-ch)
            reports (aggregate-reports reports-ch)]
        (println (format "Total : %d document(s)" (:count reports)))
        (doseq [report (:reports reports)]
          (print-report report))))))
