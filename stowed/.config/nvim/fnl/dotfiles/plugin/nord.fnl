(module dotfiles.plugin.nord
  {autoload {nvim aniseed.nvim}})

(vim.cmd "colorscheme nord")
;; Fix floating window background (hard to see comments on light background).
(vim.cmd "highlight NormalFloat ctermbg=NONE")
