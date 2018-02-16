(require '[org.httpkit.client :as http])

(defn find-auth [cookies]
    (->> 
        (clojure.string/split cookies #"; (path=/,)?")
        (filter #(clojure.string/includes? % "S_ARCHIMED_CRYSTAL_AUTH=EXPLOITATION"))
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

;;;;;;;;;;;
;;;; HTML PARSING
;;;;;;;;;;;
(use 'hickory.core)
(require '[hickory.select :as s])

(def raw-html (slurp "examples/compteur_lecteur_a_renouveller_files/dossier_lecteur.html"))

(def parse-html (comp as-hickory parse))

(def data-html (parse-html raw-html))

(defn create-keyword [label]
    (->
        (clojure.string/split label #":")
        (first)
        (clojure.string/replace #" " "-")
        (clojure.string/lower-case)
        (keyword)))

(defn select-informations [data]
    (->> data
        (s/select (s/class "dossierlecteur_linesep"))
        (map (comp first :content))
        (partition 2)
        (vec)
        (into {} (map (fn [[label value]] [(create-keyword label) value])))))

(defn find-boxes [data]
    (s/select (s/class "dossierlecteur_box") data))

(->> data-html
    (find-boxes)
    (map select-informations))
