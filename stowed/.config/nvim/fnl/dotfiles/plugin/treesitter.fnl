(module dotfiles.plugin.treesitter)

(let [(ok? ts) (pcall require :nvim-treesitter.configs)]
  (when ok?
    (ts.setup
      {:context_commentstring {:enable true} ;; JoosepAlviste/nvim-ts-context-commentstring
       :indent {:enable true}
       :highlight {:enable true
                   :additional_vim_regex_highlighting false}
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
