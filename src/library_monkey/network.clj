(ns library-monkey.network
  (:require [org.httpkit.client :as http]
            [clojure.string :as str]
            [cognitect.anomalies :as anom]
            [clojure.tools.logging :as log]))

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
      (tap> {:username username :response response})
      (log/debug (str "auth-cookie [" username "] : [" (:status response) "]" ))
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
    (log/debug (str "get-borrowings [" (:status response) "]" ))
    (cond
      (<= 200 (:status response) 299) (:body response)
      (<= 400 (:status response) 499) {::anom/category ::anom/incorrect :response response}
      :else {::anom/category ::anom/unavalaible :response response})))

(comment
  "Should be tests"

  (use 'org.httpkit.fake)

  (with-fake-http ["http://bibliotheques.amiens.fr/clientBookline/recherche/dossier_lecteur.asp" 500]
    (get-borrowings "fake-cookie"))

  (with-fake-http ["http://bibliotheques.amiens.fr/clientBookline/recherche/dossier_lecteur.asp" 401]
    (get-borrowings "fake-cookie"))

  (with-fake-http ["http://bibliotheques.amiens.fr/clientBookline/recherche/dossier_lecteur.asp" "response body"]
    (get-borrowings "fake-cookie"))

  )

(defn renew [cookie barcode]
  (let [response @(http/get "http://bibliotheques.amiens.fr/clientBookline/recherche/dossier_lecteur.asp"
                            {:query-params {"STRCODEDOCBASE" "CAAM"
                                            "ACT" "RENEW"
                                            "VALUE" barcode}
                             :headers {"Cookie" cookie}
                             :follow-redirects false})]
    (tap> {:barcode barcode :response response})
    response))
