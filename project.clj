(defproject library-monkey "0.1.0"
  :dependencies [[org.clojure/clojure "1.10.0"]
                 [http-kit "2.6.0"]
                 [http-kit.fake "0.2.1"]
                 [hickory "0.7.1"]
                 [com.cognitect/anomalies "0.1.12"]
                 [org.clojure/core.async "0.4.500"]
                 [datascript "1.3.9"]
                 [org.clojure/tools.logging "1.2.4"]
                 [org.clojure/test.check "0.9.0"]
                 [djblue/portal "0.35.1"]]
  :plugins [[lein-cljfmt "0.5.7"]]
  :main ^:skip-aot library-monkey.core
  :target-path "target/%s"
  :profiles {:uberjar {:aot :all}})
