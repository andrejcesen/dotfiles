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

;; Show error codes (a rule that caused it).
;; `open_flaot` resolves only global options, hence we need to specify it in `vim.diagnostic`
;; https://github.com/neovim/neovim/issues/17651
(vim.diagnostic.config {:severity_sort true
                        :float {:format (fn [diagnostic] 
                                          (string.format "%s [%s]"
                                                         diagnostic.message
                                                         (or diagnostic.code "")))}})

(let [(ok? typescript-tools) (pcall require :typescript-tools)]
  (typescript-tools.setup {:capabilities capabilities
                           :on_attach (fn [client bufnr]
                                        ;; Disable tsserver formatting.
                                        (tset client.server_capabilities :documentFormattingProvider false)
                                        (tset client.server_capabilities :documentRangeFormattingProvider false)
                                        (map :<leader>sa "TSToolsFixAll")
                                        (map :<leader>so "TSToolsOrganizeImports")
                                        (map :<leader>sc "TSToolsRemoveUnusedImports"))
                           :settings {:separate_diagnostic_server false}}))


(vim.lsp.config :clojure_lsp
                {:capabilities capabilities
                 :root_dir (fn [bufnr cb]
                             (let [fname (vim.api.nvim_buf_get_name 0)]
                               (when (not (string.match fname "conjure%-log%-"))
                                 (let [markers ["deps.edn" "build.boot" "shadow-cljs.edn" "bb.edn"]
                                       root (or (vim.fs.root fname markers)
                                                (vim.fs.root fname [".git"]))]
                                   (when root (cb root))))))})

(vim.lsp.enable :clojure_lsp)

(vim.lsp.config :cssls {:capabilities capabilities})
(vim.lsp.enable :cssls)

(vim.lsp.config :eslint
  {:capabilities capabilities
   :on_attach (fn [client]
                (tset client.server_capabilities :documentFormattingProvider true))})
(vim.lsp.enable :eslint)

(vim.lsp.config :html {:capabilities capabilities})
(vim.lsp.enable :html)

(vim.lsp.config :jsonls {:capabilities capabilities})
(vim.lsp.enable :jsonls)

(vim.lsp.config :pyright {:capabilities capabilities})
(vim.lsp.enable :pyright)

;; https://github.com/creativenull/efmls-configs-nvim/blob/main/lua/efmls-configs/formatters/prettier_d.lua
(let [prettierd-config {:formatCommand "prettierd '${INPUT}' ${--range-start=charStart} ${--range-end=charEnd} --config-precedence=prefer-file"
                        :formatStdin true
                        :rootMarkers [".prettierrc"
                                      ".prettierrc.json"
                                      ".prettierrc.js"
                                      ".prettierrc.yml"
                                      ".prettierrc.yaml"
                                      ".prettierrc.json5"
                                      ".prettierrc.mjs"
                                      ".prettierrc.cjs"
                                      ".prettierrc.toml"
                                      "prettier.config.js"
                                      "prettier.config.cjs"
                                      "prettier.config.mjs"
                                      ".git"]}
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
  ;; https://github.com/lukas-reineke/dotfiles/blob/master/vim/lua/lsp/init.lua#L444
  (vim.lsp.config :efm {:capabilities capabilities
                        :init_options {:documentFormatting true
                                       :documentRangeFormatting true}
                        :filetypes (a.keys languages)
                        :root_markers [".git"]
                        :settings {:languages languages}
                        })
  (vim.lsp.enable :efm))


(map :gd "lua vim.lsp.buf.definition()")
(map :gD "lua vim.lsp.buf.declaration()")
(map :gr "lua vim.lsp.buf.references()")
(map :gi "lua vim.lsp.buf.implementation()")

(map :K "lua vim.lsp.buf.hover()")
(map :<leader>k "lua vim.lsp.buf.signature_help()")

(map :<c-n> "lua vim.diagnostic.goto_next()")
(map :<c-p> "lua vim.diagnostic.goto_prev()")

(map :<leader>sr "lua vim.lsp.buf.rename()")
(map :<leader>sf "lua vim.lsp.buf.format { async = true }")

(vim.keymap.set
  "v"
  "<leader>sf" 
  (fn []
    (let [start-pos (vim.fn.getpos "'<")
          end-pos   (vim.fn.getpos "'>")]
      (vim.lsp.buf.format
        {:range {:start [(- (. start-pos 2) 1)
                         (- (. start-pos 3) 1)]
                 :end   [(- (. end-pos 2) 1)
                         (- (. end-pos 3) 1)]}})))
  {:desc "Format selection with LSP"
   :noremap true})
