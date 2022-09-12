(module dotfiles.plugin.prettier
  {autoload {nvim aniseed.nvim}})

(nvim.set_keymap :n :<leader>sp "<Plug>(Prettier)" {})
