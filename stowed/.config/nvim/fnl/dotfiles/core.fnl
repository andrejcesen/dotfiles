(module dotfiles.core
  {autoload {nvim aniseed.nvim}})

;; Generic Neovim configuration.
(set nvim.o.updatetime 500)
(set nvim.o.timeoutlen 500)
(set nvim.o.sessionoptions "blank,curdir,folds,help,tabpages,winsize")
(set nvim.o.inccommand :split)

;; this causes some intermittent underlinings
;(nvim.ex.set :spell)
(nvim.ex.set :list)

;; Reserve column for signs to prevent indenting while editing.
(nvim.ex.set "signcolumn=yes:1")
