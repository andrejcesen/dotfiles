(module dotfiles.plugin.fugitive
  {autoload {util dotfiles.util}})

(util.lnnoremap :gs "Git")
(util.lnnoremap :gb "Git blame")
(util.lnnoremap :gdv "Gvdiffsplit")
; https://youtu.be/FrMRyXtiJkc?t=828
(util.lnnoremap "gd[" "<cmd>diffget //2<CR>")
(util.lnnoremap "gd]" "<cmd>diffget //3<CR>")
(util.lnnoremap :gp "Git push")
(util.lnnoremap :gl "Git pull")
(util.lnnoremap :gf "Git fetch")
(util.lnnoremap :gcc "Git commit --verbose")
(util.lnnoremap :gca "Git commit --all --verbose")
