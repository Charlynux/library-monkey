(ns library-monkey.network
  (:require [org.httpkit.client :as http]
            [clojure.string :as str]
            [cognitect.anomalies :as anom]))

(defn find-auth-cookie [cookies]
  (->>
   (str/split cookies #"; (path=/,)?")
   (filter #(str/includes? % "S_ARCHIMED_CRYSTAL_AUTH=EXPLOITATION"))
   first))

(defn auth-cookie [username password]
  (try
    (let [response
          @(http/post "http://bibliotheques.amiens.fr/CDA/pages/logon.aspx"
                      {:query-params {"INSTANCE" "EXPLOITATION"}
                       :form-params {:name username
                                     :pwd password}
                       :follow-redirects false})]
      (case (:status response)
        302 ((comp find-auth-cookie :set-cookie :headers) response)
        200 {::anom/category ::forbidden}
        {::anom/category ::fault :response response}))
    (catch Exception e { ::anom/category :fault :exception e })))

(comment
  (auth-cookie "O3OIU" "oiheorier")
  )

(defn get-borrowings [cookie]
  (let [response
        @(http/get "http://bibliotheques.amiens.fr/clientBookline/recherche/dossier_lecteur.asp"
                   {:query-params {"INSTANCE" "EXPLOITATION"
                                   "OUTPUT" "CANVAS"
                                   "STRCODEDOCBASE" "CAAM"}
                    :headers {"Cookie" cookie}
                    :follow-redirects false})]
    (:body response)))

(defn renew [cookie barcode]
  (let [response @(http/get "http://bibliotheques.amiens.fr/clientBookline/recherche/dossier_lecteur.asp"
                            {:query-params {"STRCODEDOCBASE" "CAAM"
                                            "VALUE" barcode}
                             :headers {"Cookie" cookie}
                             :follow-redirects false})]
    response))
