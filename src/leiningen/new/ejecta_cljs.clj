(ns leiningen.new.ejecta-cljs
  (:require [leiningen.new.templates :refer [renderer name-to-path ->files]]))

(def render (renderer "ejecta-cljs"))

(defn ejecta-cljs [name]
  (let [data {:name name :sanitized (name-to-path name)}]
    (->files data
      ;; Clojure
      ["project.clj" (render "project.clj" data)]
      ["Clojure/{{sanitized}}/index.cljs" (render "core.cljs" data)]
      ["README.md" (render "README.md" data)]
      [".gitignore" (render "gitignore" data)]

      ["script/repl.clj" (render "repl.clj" data)]
      ["script/init" (render "init" data)]
      
      ;; Objective-C
      ["resources/objc/index.js" (render "index.js" data)]
      ["resources/objc/Podfile" (render "Podfile" data)]
      ["resources/objc/AppDelegate.h" (render "EjectaCLJS/AppDelegate.h")]
      ["resources/objc/AppDelegate.m" (render "EjectaCLJS/AppDelegate.m")]))))
