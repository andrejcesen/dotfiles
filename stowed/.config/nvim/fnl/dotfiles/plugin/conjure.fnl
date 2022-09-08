(module dotfiles.plugin.conjure
  {autoload {nvim aniseed.nvim}})

(set nvim.g.conjure#eval#result_register "*")
(set nvim.g.conjure#log#botright true)
(set nvim.g.conjure#mapping#doc_word "gk")

;; Evaluates an atom with @ prefix
;; https://clojurians-log.clojureverse.org/conjure/2021-01-20
(nvim.set_keymap :n :<localleader>ed :<localleader>Eie {})
