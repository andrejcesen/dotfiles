(module dotfiles.plugin.feline)

(let [(ok? lualine) (pcall require :lualine)]
  (when ok?
    (lualine.setup
      {;; Show relative path.
       :sections {:lualine_c [{1 :filename
                               :filestatus true
                               :path 1}]}})))
