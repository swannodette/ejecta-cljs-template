(require
  '[cljs.repl :as repl]
  '[ambly.core :as ambly])

(repl/repl (ambly/repl-env))
