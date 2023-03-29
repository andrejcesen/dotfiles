(module dotfiles.plugin.neomake
  {autoload {nvim aniseed.nvim}})

(when (= 1 (nvim.fn.executable "cs"))
  ;; Configure Neomake when entering $CODESCENE_HOME
  (nvim.ex.autocmd "BufNewFile,BufRead $CODESCENE_HOME/* call neomake#configure#automake('rw', 1000)")

  (set nvim.g.neomake_codescene_maker
       {:exe "cs"
        :args ["check"]
        "errorformat" (.. "%tnfo: %f:%l: %m," "%tarn: %f:%l: %m")})
  (set nvim.g.neomake_clojure_enabled_makers ["codescene"])
  (set nvim.g.neomake_javascriptreact_enabled_makers ["codescene"])
  (set nvim.g.neomake_javascript_enabled_makers ["codescene"])
  (set nvim.g.neomake_typescriptreact_enabled_makers ["codescene"])
  (set nvim.g.neomake_typescript_enabled_makers ["codescene"])
  (set nvim.g.neomake_java_enabled_makers ["codescene"]))
