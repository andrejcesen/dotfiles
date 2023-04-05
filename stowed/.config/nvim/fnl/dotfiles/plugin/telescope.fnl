(module dotfiles.plugin.telescope
  {autoload {nvim aniseed.nvim
             nu aniseed.nvim.util
             util dotfiles.util}})
(nu.fn-bridge
  :GrepSearch
  :dotfiles.plugin.telescope :grep-search)

(defn grep-search []
  (let [builtin (require :telescope.builtin)]
    (builtin.grep_string {:search (nvim.fn.input "Grep > ")})))

(let [(ok? telescope) (pcall require :telescope)]
  (when ok?
    (telescope.setup
      {:defaults
       ; `hidden = true` is not supported in text grep commands.
       {:vimgrep_arguments ["rg" "--color=never" "--no-heading"
                            "--with-filename" "--line-number" "--column"
                            "--smart-case" "--follow"
                            ; Trim whitespace at the beginning of a preview.
                            "--trim"
                            ; Search in hidden/dot files.
                            "--hidden"
                            ; Don't search in the `.git` folder.
                            "--iglob" "!**/.git/*"]}
       ; `hidden = true` will still show the inside of `.git/` as it's not `.gitignore`d.
       :pickers {:find_files {:find_command ["rg" "--files" "--hidden"
                                             "--iglob" "!**/.git/*"]
                              :mappings {:i {"<M-u>" "results_scrolling_up"
                                             "<M-d>" "results_scrolling_down"}}}
                 :live_grep {:mappings {:i {"<M-u>" "results_scrolling_up"
                                            "<M-d>" "results_scrolling_down"}}}
                 :buffers {:mappings {:i {"<M-d>" "delete_buffer"}
                                      :n {"<M-d>" "delete_buffer"}}}}})

    (telescope.load_extension :ui-select)
    (telescope.load_extension :git_worktree)

    (util.lnnoremap :ff "Telescope find_files")
    (util.lnnoremap :fF "Telescope git_files")
    (util.lnnoremap :fg "Telescope live_grep")
    (util.lnnoremap :fG ":call GrepSearch()")
    (util.lnnoremap :* "Telescope grep_string")
    (util.lnnoremap :fb "Telescope buffers")
    (util.lnnoremap :fH "Telescope help_tags")
    (util.lnnoremap :fm "Telescope keymaps")
    (util.lnnoremap :fM "Telescope marks")
    (util.lnnoremap :fh "Telescope oldfiles")
    (util.lnnoremap :ft "Telescope filetypes")
    (util.lnnoremap :fc "Telescope commands")
    (util.lnnoremap :fC "Telescope command_history")
    (util.lnnoremap :fq "Telescope quickfix")
    (util.lnnoremap :fl "Telescope loclist")
    (util.lnnoremap :fsa "lua vim.lsp.buf.code_action()")
    (util.lnnoremap :fsi "Telescope lsp_implementations")
    (util.lnnoremap :fsr "Telescope lsp_references")
    (util.lnnoremap :fsS "Telescope lsp_document_symbols")
    (util.lnnoremap :fss "Telescope lsp_workspace_symbols")
    (util.lnnoremap :gw "Telescope git_worktree git_worktrees")
    (util.lnnoremap :gm "Telescope git_worktree create_git_worktree")))
