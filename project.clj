(defproject library-monkey "0.1.0"
  :dependencies [[org.clojure/clojure "1.9.0"]
                 [http-kit "2.2.0"]
                 [hickory "0.7.1"]
                 [com.cognitect/anomalies "0.1.12"]]
  :plugins [[lein-cljfmt "0.5.7"]]
  :main ^:skip-aot library-monkey.core
  :target-path "target/%s"
  :profiles {:uberjar {:aot :all}})
