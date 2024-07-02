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
;; Don't attach LSP to Conjure log files
;; https://www.reddit.com/r/neovim/comments/168u3e4/how_to_cancel_lsp_attach_to_certain_buffer/
(vim.api.nvim_create_autocmd [:LspAttach] {:callback (fn [args] 
                                                       (let [bufname (vim.api.nvim_buf_get_name args.buf)]
                                                         ;; using '%' to escape dash and dot chars
                                                         (if (string.match bufname "conjure%-log%-[0-9]+%.cljc$")
                                                           ;; Defer detaching for a bit, because LspAttach event happens right before
                                                           ;; the buffer is marked as "attached", thus detaching will result in error.
                                                           (vim.defer_fn #(vim.lsp.buf_detach_client args.buf args.data.client_id)
                                                                         100))))})

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
                               :on_attach (fn [client bufnr]
                                            ;; Disable tsserver formatting.
                                            (tset client.server_capabilities :documentFormattingProvider false)
                                            (tset client.server_capabilities :documentRangeFormattingProvider false)
                                            (map :<leader>sa "TSToolsFixAll")
                                            (map :<leader>so "TSToolsOrganizeImports")
                                            (map :<leader>sc "TSToolsRemoveUnusedImports"))}))

    (lsp.clojure_lsp.setup {:capabilities capabilities
                            ;; Allows running a single LSP under a monorepo.
                            ;; Eg. if we have `a/deps.edn` and `b/deps.edn`, and you want it to grab the root `deps.edn`.
                            ;; https://clojurians-log.clojureverse.org/lsp/2023-02-07
                            ;; https://www.reddit.com/r/neovim/comments/ox93b5/comment/h7l62ty/?utm_source=share&utm_medium=web3x&utm_name=web3xcss&utm_term=1&utm_content=share_button
                            :root_dir (fn [filename]
                                        (let [git-root (lsp-util.find_git_ancestor filename)
                                              find-root-pattern (lsp-util.root_pattern "project.clj"
                                                                                       "deps.edn"
                                                                                       "build.boot"
                                                                                       "shadow-cljs.edn"
                                                                                       "bb.edn")]
                                          ;; First, search from the git root.
                                          ;; Otherwise, search from the opened file location.
                                          ;; https://github.com/neovim/nvim-lspconfig/blob/master/lua/lspconfig/server_configurations/clojure_lsp.lua
                                          (or (and git-root (find-root-pattern git-root))
                                              (find-root-pattern filename))))})

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
