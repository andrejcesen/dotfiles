(module config.plugin.cmp
  {autoload {nvim aniseed.nvim
             cmp cmp}})

(def- cmp-src-menu-items
  {:buffer "buff"
   :conjure "conj"
   :nvim_lsp "lsp"})

(def- cmp-srcs
  [{:name :nvim_lsp}
   {:name :conjure}
   {:name :luasnip}
   {:name :buffer}])

(def- luasnip
  (let [(ok? luasnip) (pcall require :luasnip)]
    (when ok? luasnip)))

(when luasnip
  (let [(ok? loaders-from-vscode) (pcall require "luasnip.loaders.from_vscode")]
    (when ok? (loaders-from-vscode.lazy_load))))

;; Setup cmp with desired settings
(cmp.setup {:formatting
            {:format (fn [entry item]
                       (set item.menu (or (. cmp-src-menu-items entry.source.name) ""))
                       item)}
            :mapping {:<C-p> (cmp.mapping (fn [fallback]
                                            (if (cmp.visible)
                                              (cmp.select_prev_item)
                                              (if (luasnip.jumpable -1)
                                                (luasnip.jump -1)
                                                (fallback))))
                                          [:i :s])
                      :<C-n> (cmp.mapping (fn [fallback]
                                            (if (cmp.visible)
                                              (cmp.select_next_item)
                                              (if (luasnip.expand_or_jumpable)
                                                (luasnip.expand_or_jump)
                                                (fallback))))
                                          [:i :s])
                      :<C-b> (cmp.mapping.scroll_docs (- 4))
                      :<C-f> (cmp.mapping.scroll_docs 4)
                      :<C-Space> (cmp.mapping.complete)
                      :<C-e> (cmp.mapping.close)
                      :<CR> (cmp.mapping.confirm {:behavior cmp.ConfirmBehavior.Replace
                                                  :select true})}
            :sources cmp-srcs
            :snippet {:expand (fn [args]
                                (when luasnip (luasnip.lsp_expand args.body)))}})

(cmp.setup.filetype :fennel {:sources [{:name :nvim_lsp}
                                       {:name :conjure}
                                       ;; Selecting snippets causes huge slowdowns in :fennel
                                       ;; Issue: https://github.com/rafamadriz/friendly-snippets/issues/152
                                       ; {:name :luasnip}
                                       {:name :buffer}]})
