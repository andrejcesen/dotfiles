(module dotfiles.plugin.lspconfig
  {autoload {util dotfiles.util
             a aniseed.core
             nvim aniseed.nvim
             lsp-util lspconfig.util}})

(defn- map [from to]
  (util.nnoremap from to))

(def- capabilities 
  (let [(ok? cmp-lsp) (pcall require "cmp_nvim_lsp")]
    (when ok?
      (cmp-lsp.default_capabilities))))

(let [(ok? lsp) (pcall require :lspconfig)]
  (when (not ok?) nil)
  ;server features
  (let [handlers {"textDocument/publishDiagnostics"
                  (vim.lsp.with
                    vim.lsp.diagnostic.on_publish_diagnostics
                    {:severity_sort true})}]

    ;; Show error codes (a rule that caused it).
    ;; `open_flaot` resolves only global options, hence we need to specify it in `vim.diagnostic`
    ;; https://github.com/neovim/neovim/issues/17651
    (vim.diagnostic.config {:float {:format (fn [diagnostic] 
                                              (string.format "%s [%s]"
                                                             diagnostic.message
                                                             (or diagnostic.code "")))}})

    (let [(ok? typescript-tools) (pcall require :typescript-tools)]
      (when (not ok?) nil)

      (typescript-tools.setup {:capabilities capabilities
                               :handlers handlers
                               :on_attach (fn [client bufnr]
                                            ;; Disable tsserver formatting.
                                            (tset client.server_capabilities :documentFormattingProvider false)
                                            (tset client.server_capabilities :documentRangeFormattingProvider false)
                                            (map :<leader>sa "TSToolsFixAll")
                                            (map :<leader>so "TSToolsOrganizeImports")
                                            (map :<leader>sc "TSToolsRemoveUnusedImports"))}))

    (lsp.clojure_lsp.setup {:capabilities capabilities
                            :handlers handlers})

    (lsp.cssls.setup {:capabilities capabilities
                      :handlers handlers})
    
    (lsp.eslint.setup
      {:capabilities capabilities
       :handlers handlers
       :on_attach (fn [client]
                    (tset client.server_capabilities :documentFormattingProvider true))})

    (lsp.html.setup {:capabilities capabilities
                     :handlers handlers})

    (lsp.jsonls.setup {:capabilities capabilities
                       :handlers handlers})

    (lsp.pyright.setup {:capabilities capabilities
                        :handlers handlers})

    (lsp.lua_ls.setup
      {:capabilities capabilities
       :cmd ["lua-language-server"]
       :handlers handlers
       :settings {:Lua {:telemetry {:enable false}}}})

    (lsp.rust_analyzer.setup {:capabilities capabilities
                              :handlers handlers
                              :settings {:rust-analyzer {:checkOnSave {:command :clippy}}}})

    ;; https://github.com/lukas-reineke/dotfiles/blob/master/vim/lua/lsp/init.lua#L444
    (let [prettierd-config {:formatCommand (.. "prettierd ${INPUT} ${--range-start=charStart} ${--range-end=charEnd} "
                                               "${--tab-width=tabSize} ${--use-tabs=!insertSpaces}")
                            :formatStdin true}
          languages {:javascript [prettierd-config]
                     :typescript [prettierd-config]
                     :javascriptreact [prettierd-config]
                     :typescriptreact [prettierd-config]
                     :yaml [prettierd-config]
                     :json [prettierd-config]
                     :html [prettierd-config]
                     :scss [prettierd-config]
                     :less [prettierd-config]
                     :css [prettierd-config]
                     :markdown [prettierd-config]}]
      (lsp.efm.setup {:capabilities capabilities
                      :handlers handlers
                      :init_options {:documentFormatting true}
                      :root_dir vim.loop.cwd
                      :filetypes (a.keys languages)
                      :settings {:rootMarkers [".git/"]
                                 :languages languages}}))

    (map :gd "lua vim.lsp.buf.definition()")
    (map :gD "lua vim.lsp.buf.declaration()")
    (map :gr "lua vim.lsp.buf.references()")
    (map :gi "lua vim.lsp.buf.implementation()")

    (map :K "lua vim.lsp.buf.hover()")
    (map :<leader>k "lua vim.lsp.buf.signature_help()")

    (map :<c-n> "lua vim.diagnostic.goto_next()")
    (map :<c-p> "lua vim.diagnostic.goto_prev()")

    (map :<leader>sr "lua vim.lsp.buf.rename()")
    (map :<leader>sf "lua vim.lsp.buf.format { async = true }")))
