(module dotfiles.plugin.lspconfig
  {autoload {util dotfiles.util
             nvim aniseed.nvim
             lsp-util lspconfig.util}})

(defn- map [from to]
  (util.nnoremap from to))

(def- capabilities 
  (let [(ok? cmp-lsp) (pcall require "cmp_nvim_lsp")]
    (when ok?
      (cmp-lsp.default_capabilities))))

;; Enables tsserver automatically, no need to call lsp.tsserver.setup
(let [(ok? typescript) (pcall require :typescript)]
  (when ok?
    (typescript.setup
      ;; LSP config options
      {:server {:capabilities capabilities}})))

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
                                                             diagnostic.code))}})

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
    (lsp.pyright.setup
      ;; Default config.
      ;; https://github.com/neovim/nvim-lspconfig/blob/master/lua/lspconfig/server_configurations/pyright.lua
      {:capabilities capabilities
       :handlers handlers
       :root_dir (lsp-util.root_pattern "pyproject.toml"
                                        "setup.py"
                                        "setup.cfg"
                                        ;; Removed for correct root folder
                                        ;; resolution in Pitch project.
                                        ; "requirements.txt"
                                        "Pipfile"
                                        "pyrightconfig.json")})
    (lsp.lua_ls.setup
      {:capabilities capabilities
       :cmd ["lua-language-server"]
       :handlers handlers
       :settings {:Lua {:telemetry {:enable false}}}})

    ;; https://www.chrisatmachine.com/Neovim/27-native-lsp/
    (map :gd "lua vim.lsp.buf.definition()")
    (map :gD "lua vim.lsp.buf.declaration()")
    ;; Tries to find implementation file — even if those files are normally
    ;; shadowed by .d.ts files.
    (map :gsd "TypescriptGoToSourceDefinition")
    (map :gr "lua vim.lsp.buf.references()")
    (map :gi "lua vim.lsp.buf.implementation()")
    (map :K "lua vim.lsp.buf.hover()")
    (map :<leader>k "lua vim.lsp.buf.signature_help()")
    (map :<c-n> "lua vim.diagnostic.goto_next()")
    (map :<c-p> "lua vim.diagnostic.goto_prev()")

    (map :<leader>sr "lua vim.lsp.buf.rename()")
    (map :<leader>sf "lua vim.lsp.buf.format { async = true }")
    (map :<leader>sta "TypescriptFixAll<cr>")
    (map :<leader>sti "TypescriptAddMissingImports<cr>")
    (map :<leader>sto "TypescriptOrganizeImports<cr>")
    (map :<leader>str "TypescriptRemoveUnused<cr>")))
