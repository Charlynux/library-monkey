(ns library-monkey.network
    (:require [org.httpkit.client :as http]
        [clojure.string :as str]))

(defn find-auth-cookie [cookies]
    (->> 
        (str/split cookies #"; (path=/,)?")
        (filter #(str/includes? % "S_ARCHIMED_CRYSTAL_AUTH=EXPLOITATION"))
        (first)))

(defn auth-cookie [username password]
    (let [response
        @(http/post "http://bibliotheques.amiens.fr/CDA/pages/logon.aspx?INSTANCE=EXPLOITATION" 
            {
                :form-params { 
                    :name username
                    :pwd password
                }
                :follow-redirects false
            })]
            ;;; Success = 302...
            ((comp find-auth-cookie :set-cookie :headers) response)))

(defn get-borrowings [cookie]
    (let [response 
        @(http/get "http://bibliotheques.amiens.fr/clientBookline/recherche/dossier_lecteur.asp?INSTANCE=EXPLOITATION&OUTPUT=CANVAS&STRCODEDOCBASE=CAAM" 
        {
            :headers {
                "Accept" "application/json"
                "Cookie" cookie
            }
            :follow-redirects false
        })] 
        (:body response)))
  