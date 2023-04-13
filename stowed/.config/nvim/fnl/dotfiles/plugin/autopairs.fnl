(module dotfiles.plugin.autopairs
  {require {a aniseed.core}})

(def lisps [:clojure :fennel :lisp :scheme])

(defn disable-rule-for-lisps []
  (let [autopairs (require :nvim-autopairs)
        existing-excludes (a.get-in (autopairs.get_rule "'") [1 :not_filetypes])
        excludes (a.concat existing-excludes lisps)]
    (a.assoc-in (autopairs.get_rule "'") [1 :not_filetypes] excludes)))

(let [(ok? autopairs) (pcall require :nvim-autopairs)]
  (when ok?
    (autopairs.setup {"enable_check_bracket_line" false})
    (disable-rule-for-lisps)))
