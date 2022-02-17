(ns library-monkey.configuration
  (:require
   [clojure.spec.alpha :as s]
   [clojure.spec.gen.alpha :as gen]))

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
