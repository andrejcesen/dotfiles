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
  (vim.api.nvim_create_autocmd [:BufWritePost :BufReadPost]
                               {:pattern [(.. nvim.env.CODESCENE_DEV_HOME "/*")]
                                :group (vim.api.nvim_create_augroup :neomake_in_codescene {:clear true})
                                :callback (fn [args]
                                            (let [bufname (vim.api.nvim_buf_get_name args.buf)]
                                              (when (not (string.match bufname ".*://"))
                                                ;; Without vim.schedule it runs only once. No clue why...
                                                (vim.schedule #(vim.cmd "Neomake")))))}))
