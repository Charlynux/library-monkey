(require '[org.httpkit.client :as http])

(defn find-auth [cookies]
    (->> 
        (clojure.string/split cookies #"; (path=/,)?")
        (filter #(clojure.string/includes? % "S_ARCHIMED_CRYSTAL_AUTH=EXPLOITATION"))
        (first)))


(defn auth-cookie [name password]
    (let [response
        @(http/post "http://bibliotheques.amiens.fr/CDA/pages/logon.aspx?INSTANCE=EXPLOITATION" 
            {
                :form-params { 
                    :name name
                    :pwd password
                }
                :follow-redirects false
            })]
            ((comp find-auth :set-cookie :headers) response)))

(defn get-borrowings [cookie]
    (let [response 
        @(http/get "http://bibliotheques.amiens.fr/cda/default.aspx?INSTANCE=EXPLOITATION&PORTAL_ID=erm_portal_services.xml&PAGE=/clientBookline/recherche/dossier_lecteur.asp%3FINSTANCE%3DEXPLOITATION%26OUTPUT%3DCANVAS%26STRCODEDOCBASE%3DCAAM" 
        {
            :headers {
                "Accept" "application/json"
                "Cookie" cookie
            }
            :follow-redirects false
        })] 
        (println (:error response))
        (println (:status response))))
