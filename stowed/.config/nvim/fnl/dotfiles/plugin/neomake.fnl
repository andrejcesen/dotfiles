(module dotfiles.plugin.neomake
  {autoload {nvim aniseed.nvim}})

(when (= 1 (nvim.fn.executable "cs"))
  (set nvim.g.neomake_codescene_maker
       {:exe "cs"
        :args ["check"]
        "errorformat" (.. "%tnfo: %f:%l: %m," "%tarn: %f:%l: %m")})

  (set nvim.g.neomake_clojure_enabled_makers ["codescene"])
  (set nvim.g.neomake_javascriptreact_enabled_makers ["codescene"])
  (set nvim.g.neomake_javascript_enabled_makers ["codescene"])
  (set nvim.g.neomake_typescriptreact_enabled_makers ["codescene"])
  (set nvim.g.neomake_typescript_enabled_makers ["codescene"])
  (set nvim.g.neomake_java_enabled_makers ["codescene"])
  (set nvim.g.neomake_sh_enabled_makers [])

  ;; Run Neomake for codescene only, ignoring conjure log.
  ;; https://github.com/neomake/neomake/issues/2312#issuecomment-462319749
  (vim.api.nvim_create_autocmd [:FileType] {:pattern [:clojure :java
                                                      :javascriptreact
                                                      :javascript
                                                      :typescriptreact
                                                      :typescript]
                                            :callback (fn [args]
                                                        (let [path (vim.fn.expand "%:p")
                                                              codescene? (string.find path
                                                                                      nvim.env.CODESCENE_HOME
                                                                                      nil    ;; Start at index 1 (default).
                                                                                      true   ;; Turn off pattern-matching: https://stackoverflow.com/a/6077464/18714042])
                                                                                      )]
                                                          (when (and codescene? (not (string.match (vim.fn.expand "<afile>") "conjure%-log%-[0-9]+%.cljc$")))
                                                            (vim.api.nvim_call_function "neomake#configure#automake_for_buffer" ["rw" 1000]))))}))
