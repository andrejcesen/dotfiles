(module dotfiles.plugin.treesitter)

(let [(ok? ts) (pcall require :nvim-treesitter.configs)]
  (when ok?
    (ts.setup
      {:autotag {:enable true ; Enable windwp/nvim-ts-autotag
                 :enable_close_on_slash false}
       :indent {:enable true}
       :highlight {:enable true
                   ;; https://github.com/guns/vim-sexp/issues/31#issuecomment-1240936851
                   :additional_vim_regex_highlighting [:clojure :fennel :lisp :scheme]}
       :ensure_installed [:bash
                          :c
                          :clojure
                          :cmake
                          :comment
                          :commonlisp
                          :cpp
                          :css
                          :dockerfile
                          :fennel
                          :fish
                          :graphql
                          :html
                          :http
                          :java
                          :javascript
                          :jsdoc
                          :json
                          :json5
                          :jsonc
                          :kotlin
                          :latex
                          :lua
                          :make
                          :markdown
                          :regex
                          :ruby
                          :rust
                          :scss
                          :swift
                          :typescript
                          :tsx
                          :vim
                          :yaml]})))
