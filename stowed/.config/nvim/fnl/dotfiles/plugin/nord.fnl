(module dotfiles.plugin.nord
  {autoload {nvim aniseed.nvim}})

;; Fixes black border used by Treesitter Context

;; Type `:hi` to list all color groups.
;; Type `:hi Statement` to view color definition for Statement.
;; https://gist.github.com/romainl/379904f91fa40533175dfaec4c833f2f
; (vim.cmd "augroup MyColors
;     autocmd!
;     autocmd ColorScheme * highlight NormalFloat ctermbg=0 guifg=#d8dee9 guibg=#2e3440 | highlight TreesitterContext ctermbg=0 | highlight WinSeparator ctermfg=8 guifg=#434c5e guibg=#2e3440
;     augroup END")

(let [(ok? nord) (pcall #(require :nord))]
  (when ok?
    (nord.setup {:diff {:mode :fg}})))


(vim.cmd "colorscheme nord")

(nvim.ex.set "cursorline")
;; MacOS Terminal renders colors weirdly whenever you have a background set... Thus disable background highlight.
;; More info:
; https://stackoverflow.com/questions/73607078/foreground-and-background-color-rendered-differently-in-macos-terminal-app
; https://apple.stackexchange.com/questions/282911/prevent-mac-terminal-brightening-font-color-with-no-background/446604#446604
; (vim.cmd "highlight CursorLine cterm=NONE ctermbg=NONE ctermfg=NONE guibg=NONE guifg=NONE")
; (vim.cmd "highlight CursorLineNR cterm=bold")
