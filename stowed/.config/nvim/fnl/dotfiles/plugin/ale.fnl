(module dotfiles.plugin.ale
  {autoload {nvim aniseed.nvim}})

(set nvim.g.ale_linters
  {:javascript [:standard]
   :typescript []
   :typescriptreact []
   :clojure []
   :python []})
