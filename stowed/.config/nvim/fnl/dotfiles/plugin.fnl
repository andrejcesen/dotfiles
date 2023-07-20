(module dotfiles.plugin
  {autoload {nvim aniseed.nvim
             a aniseed.core
             util dotfiles.util
             packer packer}})

(defn safe-require-plugin-config [name]
  (let [(ok? val-or-err) (pcall require (.. :dotfiles.plugin. name))]
    (when (not ok?)
      (print (.. "dotfiles error: " val-or-err)))))

(defn- use [...]
  "Iterates through the arguments as pairs and calls packer's use function for
  each of them. Works around Fennel not liking mixed associative and sequential
  tables as well."
  (let [pkgs [...]]
    (packer.startup
      (fn [use]
        (for [i 1 (a.count pkgs) 2]
          (let [name (. pkgs i)
                opts (. pkgs (+ i 1))]
            (-?> (. opts :mod) (safe-require-plugin-config))
            (use (a.assoc opts 1 name)))))))
  nil)

;; Plugins to be managed by packer.
(use
  :Olical/AnsiEsc {}
  :Olical/aniseed {}
  :Olical/conjure {:mod :conjure}
  :Olical/nvim-local-fennel {}
  :arcticicestudio/nord-vim {:branch :main :mod :nord}
  :kyazdani42/nvim-web-devicons {}
  :airblade/vim-gitgutter {}
  :clojure-vim/clojure.vim {}
  :clojure-vim/vim-jack-in {}
  :dag/vim-fish {}
  :folke/which-key.nvim {:mod :which-key}
  :ggandor/leap.nvim {:mod :leap}
  :guns/vim-sexp {:mod :sexp}
  :hrsh7th/nvim-cmp {:mod :cmp :requires [:hrsh7th/cmp-nvim-lsp
                                          :hrsh7th/cmp-buffer
                                          :PaterJason/cmp-conjure
                                          :saadparwaiz1/cmp_luasnip
                                          :L3MON4D3/LuaSnip
                                          :rafamadriz/friendly-snippets]}
  :iamcco/markdown-preview.nvim {:run "cd app && yarn install"
                                 :mod :markdown-preview
                                 :ft [:markdown]}
  :lewis6991/impatient.nvim {}
  :mbbill/undotree {:mod :undotree}
  :neovim/nvim-lspconfig {:mod :lspconfig :requires [[:jose-elias-alvarez/typescript.nvim]]}
  :nvim-lualine/lualine.nvim {:mod :lualine}
  :nvim-telescope/telescope.nvim {:mod :telescope :requires [[:nvim-lua/popup.nvim]
                                                             [:nvim-lua/plenary.nvim]
                                                             [:nvim-telescope/telescope-ui-select.nvim]]}
  :ThePrimeagen/git-worktree.nvim {:mod :git-worktree}
  :ThePrimeagen/harpoon {:mod :harpoon}
  :JoosepAlviste/nvim-ts-context-commentstring {}
  :neomake/neomake {:mod :neomake}
  :nvim-treesitter/nvim-treesitter {:run ":TSUpdate"
                                    :mod :treesitter
                                    :requires [[:windwp/nvim-ts-autotag]]}
  :nvim-treesitter/nvim-treesitter-context {}
  :prettier/vim-prettier {:mod :prettier}
  :radenling/vim-dispatch-neovim {}
  :tpope/vim-abolish {}
  :tpope/vim-commentary {}
  :tpope/vim-dadbod {}
  :tpope/vim-dispatch {}
  :tpope/vim-eunuch {}
  :tpope/vim-fugitive {:mod :fugitive}
  :tpope/vim-repeat {}
  :tpope/vim-rhubarb {}
  :tpope/vim-sexp-mappings-for-regular-people {}
  :tpope/vim-sleuth {}
  :tpope/vim-surround {}
  :tpope/vim-unimpaired {}
  :tpope/vim-vinegar {}
  :w0rp/ale {:mod :ale}
  :wbthomason/packer.nvim {}
  :windwp/nvim-autopairs {:mod :autopairs}
  )
