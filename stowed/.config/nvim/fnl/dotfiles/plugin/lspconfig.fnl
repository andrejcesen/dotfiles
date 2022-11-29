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
(let [(ok? typescript) (pcall require :typescript) ]
  (when ok?
    (typescript.setup
      ;; LSP config options
      {:server {:capabilities capabilities}})))

(let [(ok? lsp) (pcall require :lspconfig)]
  (when ok?
    (lsp.clojure_lsp.setup {})
    (lsp.cssls.setup {})
    (lsp.eslint.setup
      {:on_attach (fn [client]
                    (tset client.server_capabilities :documentFormattingProvider true))})
    (lsp.html.setup {})
    (lsp.jsonls.setup {})
    (lsp.pyright.setup
      ;; Default config.
      ;; https://github.com/neovim/nvim-lspconfig/blob/master/lua/lspconfig/server_configurations/pyright.lua
      {:root_dir (lsp-util.root_pattern "pyproject.toml"
                                        "setup.py"
                                        "setup.cfg"
                                        ;; Removed for correct root folder
                                        ;; resolution in Pitch project.
                                        ; "requirements.txt"
                                        "Pipfile"
                                        "pyrightconfig.json")})
    (lsp.sumneko_lua.setup
      {:cmd ["lua-language-server"]
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
    (map :<leader>so "TypescriptOrganizeImports<cr>")))
