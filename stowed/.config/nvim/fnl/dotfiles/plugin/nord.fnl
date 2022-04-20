(module dotfiles.plugin.nord
  {autoload {nvim aniseed.nvim}})

;; NormalFloat (conjure): fix floating window background (hard to see comments on light background).
;; LightspeedGreyWash (lightspeed.nvim)
;; https://gist.github.com/romainl/379904f91fa40533175dfaec4c833f2f
(vim.cmd "augroup MyColors
    autocmd!
    autocmd ColorScheme * highlight link LightspeedGreyWash Comment | highlight NormalFloat ctermbg=NONE
    augroup END")

(vim.cmd "colorscheme nord")
