(module dotfiles.plugin.conjure
  {autoload {nvim aniseed.nvim}})

(set nvim.g.conjure#eval#result_register "*")
(set nvim.g.conjure#log#botright true)
(set nvim.g.conjure#mapping#doc_word "gk")

;; Disable rust
(set nvim.g.conjure#filetypes [:clojure
                               :fennel
                               :racket
                               :scheme
                               :lua
                               :lisp
                               :python])
;; https://github.com/Olical/conjure/issues/472
(set nvim.g.conjure#filetype#rust false)

;; Evaluates an atom with @ prefix
;; https://clojurians-log.clojureverse.org/conjure/2021-01-20
(nvim.set_keymap :n :<localleader>ed :<localleader>Eie {})
