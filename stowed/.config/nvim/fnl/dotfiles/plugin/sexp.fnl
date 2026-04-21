(module dotfiles.plugin.sexp
  {autoload {nvim aniseed.nvim}})

(set nvim.g.sexp_filetypes "clojure,scheme,lisp,timl,fennel,janet")

(set nvim.g.sexp_mappings
  {:sexp_put_before "<LocalLeader>P"
   :sexp_put_after "<LocalLeader>p"
   :sexp_replace {:x "<LocalLeader>p"
                  :n "<LocalLeader><LocalLeader>p"}
   :sexp_replace_P {:x "<LocalLeader>P"
                    :n "<LocalLeader><LocalLeader>P"}})
