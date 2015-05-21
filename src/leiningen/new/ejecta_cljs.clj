(ns leiningen.new.ejecta-cljs
  (:require [clojure.string :as string]
            [leiningen.new.templates :refer [renderer name-to-path ->files]]))

(def render (renderer "ejecta-cljs"))

(defn camelize [s]
  (apply str (map #(apply str (.toUpperCase (str (first %))) (rest %)) (string/split s #"-"))))

(defn ejecta-cljs [name]
  (let [data {:name name :sanitized (name-to-path name) :camelized (camelize name)}]
    (->files data
      ;; Clojure
      ["project.clj" (render "project.clj" data)]
      ["README.md" (render "README.md" data)]
      [".gitignore" (render "gitignore" data)]

      ["script/repl.clj" (render "repl.clj" data)]
      ["script/repl" (render "repl" data) :executable true]
      ["script/init" (render "init" data) :executable true]
      
      ;; Objective-C
      ["resources/objc/index.js" (render "index.js" data)]
      ["resources/objc/Podfile" (render "Podfile" data)]
      ["resources/objc/AppDelegate.h" (render "EjectaCLJS/AppDelegate.h")]
      ["resources/objc/AppDelegate.m" (render "EjectaCLJS/AppDelegate.m")])))
