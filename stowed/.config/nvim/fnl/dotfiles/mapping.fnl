(module dotfiles.mapping
  {autoload {nvim aniseed.nvim
             nu aniseed.nvim.util
             core aniseed.core}})

(defn- noremap [mode from to]
  "Sets a mapping with {:noremap true}."
  (nvim.set_keymap mode from to {:noremap true}))

;; Generic mapping configuration.
(nvim.set_keymap :n :<space> :<nop> {:noremap true})
(set nvim.g.mapleader " ")
(set nvim.g.maplocalleader ",")

;; Remap original `,` behaviour to `\`, since it's now localleader.
(noremap :n :\ ",")

;; Paste without changing the default register.
(noremap :x :<leader>p "\"_dP")

;; Copy absolute path of the current buffer.
(noremap :n :<leader>c ":let @+=expand('%:p')<cr>")

;; Correct to first spelling suggestion.
(noremap :n :<leader>zz ":normal! 1z=<cr>")

;; Trim trialing whitespace.
(noremap :n :<leader>bt ":%s/\\s\\+$//e<cr>")

;; Delete hidden buffers.
(noremap :n :<leader>bo ":call DeleteHiddenBuffers()<cr>")

(nu.fn-bridge
  :DeleteHiddenBuffers
  :dotfiles.mapping :delete-hidden-buffers)

(defn delete-hidden-buffers []
  (let [visible-bufs (->> (nvim.fn.range 1 (nvim.fn.tabpagenr :$))
                          (core.map nvim.fn.tabpagebuflist)
                          (unpack)
                          (core.concat))]
    (->> (nvim.fn.range 1 (nvim.fn.bufnr :$))
         (core.filter
           (fn [bufnr]
             (and (nvim.fn.bufexists bufnr)
                  (= -1 (nvim.fn.index visible-bufs bufnr)))))
         (core.run!
           (fn [bufnr]
             (nvim.ex.bwipeout bufnr))))))
