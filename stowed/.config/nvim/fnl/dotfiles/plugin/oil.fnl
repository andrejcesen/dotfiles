(module dotfiles.plugin.oil
  {autoload {nvim aniseed.nvim
             util dotfiles.util}})

(let [(ok? oil) (pcall #(require :oil))]
  (when ok?
    (oil.setup)))

(util.nnoremap :- :Oil {:desc "Open parent directory" })
