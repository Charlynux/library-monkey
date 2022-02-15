(ns library-monkey.html-parse
  (:require [hickory.core :as h]
            [hickory.select :as s]
            [clojure.string :as str]))

(def parse-html (comp h/as-hickory h/parse))

(defn create-keyword [label]
  (->
   (str/split label #"\u00A0:\u00A0")
   first
   (str/replace #" " "-")
   (str/lower-case)
   keyword))

(defn select-informations [data]
  (->>
   (s/select (s/class "dossierlecteur_linesep") data)
   (map (comp first :content))
   (partition 2)
   vec
   (into {} (map (fn [[label value]] [(create-keyword label) value])))))

(defn find-boxes [data]
  (s/select (s/class "dossierlecteur_box") data))

(defn extract-borrowings-container [data]
  (first (s/select (s/attr "summary" #{"Prêts en cours"}) data)))

(def formatter (java.time.format.DateTimeFormatter/ofPattern "dd/MM/yyyy"))

(defn string->date [date]
  (java.time.LocalDate/parse date formatter))

(defn convert-datas [borrowing]
  (-> borrowing
      (update :date-de-retour string->date)))

(defn extract-borrowings [html]
  (->>
   (parse-html html)
   extract-borrowings-container
   find-boxes
   (map select-informations)
   (map convert-datas)))
