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

;; Opt-out of LSP's |gq| formatting.
;; This also worked unpredictably, as only the first buffer had `formatexpr` set.
(vim.api.nvim_create_autocmd [:LspAttach] {:callback (fn [args] 
                                                       (let [bo (. nvim.bo args.buf)]
                                                         (tset bo :formatexpr nil)))})

(let [(ok? lsp) (pcall require :lspconfig)]
  (when ok?

    ;; Show error codes (a rule that caused it).
    ;; `open_flaot` resolves only global options, hence we need to specify it in `vim.diagnostic`
    ;; https://github.com/neovim/neovim/issues/17651
    (vim.diagnostic.config {:severity_sort true
                            :float {:format (fn [diagnostic] 
                                              (string.format "%s [%s]"
                                                             diagnostic.message
                                                             (or diagnostic.code "")))}})

    (let [(ok? typescript-tools) (pcall require :typescript-tools)]
      (when (not ok?) nil)
      (typescript-tools.setup {:capabilities capabilities
                               :settings {;:tsserver_plugins ["@styled/typescript-styled-plugin"]
                                          }
                               :on_attach (fn [client bufnr]
                                            ;; Disable tsserver formatting.
                                            (tset client.server_capabilities :documentFormattingProvider false)
                                            (tset client.server_capabilities :documentRangeFormattingProvider false)
                                            (map :<leader>sa "TSToolsFixAll")
                                            (map :<leader>so "TSToolsOrganizeImports")
                                            (map :<leader>sc "TSToolsRemoveUnusedImports"))}))

    (lsp.clojure_lsp.setup {:capabilities capabilities
                            ; https://www.reddit.com/r/neovim/comments/xqogsu/turning_off_treesitter_and_lsp_for_specific_files/
                            :on_attach (fn [client bufnr]
                                         (when (-> (nvim.fn.bufname bufnr)
                                                   ;; using '%' to escape dash and dot chars
                                                   (string.match "^conjure%-log%-[0-9]+%.cljc$"))
                                           (vim.cmd "LspStop")))})

    (lsp.cssls.setup {:capabilities capabilities})

    (lsp.eslint.setup
      {:capabilities capabilities
       :on_attach (fn [client]
                    (tset client.server_capabilities :documentFormattingProvider true))})

    (lsp.html.setup {:capabilities capabilities})

    (lsp.jsonls.setup {:capabilities capabilities})

    (lsp.pyright.setup {:capabilities capabilities})

    (lsp.lua_ls.setup
      {:capabilities capabilities
       :cmd ["lua-language-server"]
       :settings {:Lua {:telemetry {:enable false}}}})

    (lsp.rust_analyzer.setup {:capabilities capabilities
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
