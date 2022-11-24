(module dotfiles.plugin.lspconfig
  {autoload {util dotfiles.util
             nvim aniseed.nvim
             lsp-util lspconfig.util}})

(defn- map [from to]
  (util.nnoremap from to))

(let [(ok? lsp) (pcall require :lspconfig)]
  (when ok?
    (lsp.clojure_lsp.setup {})
    (lsp.tsserver.setup {})
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
    (map :gr "lua vim.lsp.buf.references()")
    (map :gi "lua vim.lsp.buf.implementation()")
    (map :K "lua vim.lsp.buf.hover()")
    (map :<leader>k "lua vim.lsp.buf.signature_help()")
    (map :<c-n> "lua vim.diagnostic.goto_next()")
    (map :<c-p> "lua vim.diagnostic.goto_prev()")

    (map :<leader>sr "lua vim.lsp.buf.rename()")
    (map :<leader>sf "lua vim.lsp.buf.formatting()")))
