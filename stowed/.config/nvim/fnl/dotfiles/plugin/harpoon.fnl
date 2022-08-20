(module dotfiles.plugin.harpoon
  {autoload {nvim aniseed.nvim
             util dotfiles.util}})

;; https://github.com/ThePrimeagen/.dotfiles/blob/master/nvim/.config/nvim/after/plugin/keymap/harpoon.lua

(util.nnoremap :<leader>a "lua require(\"harpoon.mark\").add_file()")
(util.nnoremap :<C-e> "lua require(\"harpoon.ui\").toggle_quick_menu()")
(util.nnoremap :<leader>tc "lua require(\"harpoon.cmd-ui\").toggle_quick_menu()")

(util.nnoremap :<leader>j "lua require(\"harpoon.ui\").nav_file(1)")
(util.nnoremap :<leader>k "lua require(\"harpoon.ui\").nav_file(2)")
(util.nnoremap :<leader>l "lua require(\"harpoon.ui\").nav_file(3)")
(util.nnoremap "<leader>;" "lua require(\"harpoon.ui\").nav_file(4)")
