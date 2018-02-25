(ns library-monkey.network
  (:require [org.httpkit.client :as http]
            [clojure.string :as str]))

(def base-url "http://bibliotheques.amiens.fr")
(def logon-url (str base-url "/CDA/pages/logon.aspx?INSTANCE=EXPLOITATION"))
(def borrowings-url (str base-url "/clientBookline/recherche/dossier_lecteur.asp?INSTANCE=EXPLOITATION&OUTPUT=CANVAS&STRCODEDOCBASE=CAAM"))

(defn find-auth-cookie [cookies]
  (->>
   (str/split cookies #"; (path=/,)?")
   (filter #(str/includes? % "S_ARCHIMED_CRYSTAL_AUTH=EXPLOITATION"))
   first))

(defn auth-cookie [username password]
  (let [response
        @(http/post logon-url
                    {:form-params {:name username
                                   :pwd password}
                     :follow-redirects false})]
            ;;; Success = 302...
    ((comp find-auth-cookie :set-cookie :headers) response)))

(defn get-borrowings [cookie]
  (let [response
        @(http/get borrowings-url
                   {:headers {"Cookie" cookie}
                    :follow-redirects false})]
    (:body response)))
