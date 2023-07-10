(module dotfiles.plugin.nord
  {autoload {nvim aniseed.nvim}})

;; NormalFloat (conjure): fix floating window background (hard to see comments on light background).
;; Type `:hi` to list all color groups.
;; Type `:hi Statement` to view color definition for Statement.
;; https://gist.github.com/romainl/379904f91fa40533175dfaec4c833f2f
(vim.cmd "augroup MyColors
    autocmd!
    autocmd ColorScheme * highlight NormalFloat ctermbg=NONE | highlight TreesitterContext ctermbg=0
    augroup END")

(set nvim.g.nord_uniform_diff_background 1)
(vim.cmd "colorscheme nord")
