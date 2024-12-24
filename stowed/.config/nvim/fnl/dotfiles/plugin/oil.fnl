(module dotfiles.plugin.oil
  {autoload {nvim aniseed.nvim
             util dotfiles.util}})

(let [(ok? oil) (pcall #(require :oil))]
  (when ok?
    (oil.setup)))

(nvim.set_keymap :n :- ":Oil<cr>" {:noremap true :silent true})

; Pressing `G` shows relative path instead of absolute.
; Before: ~/path/to/dotfiles/stowed/...
; After: stowed/...
;
; Use this until this is resolved: https://github.com/stevearc/oil.nvim/issues/234
;
; Note: Using vim.api.nvim_create_autocmd doesn't work correctly, `cd` executes
; only the first time...
(vim.cmd "augroup OilRelPathFix
    autocmd!
    autocmd BufLeave oil:///* :cd .
    augroup END")
