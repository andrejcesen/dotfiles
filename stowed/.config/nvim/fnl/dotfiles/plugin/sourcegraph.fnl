(module dotfiles.plugin.sourcegraph
  {autoload {util dotfiles.util
             a aniseed.core
             nvim aniseed.nvim}})

(let [(ok? sg) (pcall require :sg)]
  (when ok?
    (sg.setup)))
