(module dotfiles.plugin.harpoon
  {autoload {nvim aniseed.nvim
             util dotfiles.util}})

;; https://github.com/ThePrimeagen/.dotfiles/blob/master/nvim/.config/nvim/after/plugin/keymap/harpoon.lua

(util.nnoremap :<leader>a  "lua require(\"harpoon.mark\").add_file()")
(util.nnoremap :<C-e>      "lua require(\"harpoon.ui\").toggle_quick_menu()")
(util.nnoremap :<leader>tc "lua require(\"harpoon.cmd-ui\").toggle_quick_menu()")

;; Set :silent to avoid flickering message on navigation.
(nvim.set_keymap :n "<C-j>" ":lua require(\"harpoon.ui\").nav_file(1)<cr>" {:noremap true
                                                                            :silent true})
(nvim.set_keymap :n "<C-k>" ":lua require(\"harpoon.ui\").nav_file(2)<cr>" {:noremap true
                                                                            :silent true})
(nvim.set_keymap :n "<C-l>" ":lua require(\"harpoon.ui\").nav_file(3)<cr>" {:noremap true
                                                                            :silent true})
(nvim.set_keymap :n "<C-h>" ":lua require(\"harpoon.ui\").nav_file(4)<cr>" {:noremap true
                                                                            :silent true})

;; Remap Nvim's <C-L> mapping. See: https://neovim.io/doc/user/vim_diff.html
(util.nnoremap :<leader>l "<Cmd>nohlsearch<Bar>diffupdate<Bar>normal! <C-L><CR>")
