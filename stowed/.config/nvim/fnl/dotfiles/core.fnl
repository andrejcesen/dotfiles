(module dotfiles.core
  {autoload {nvim aniseed.nvim}})

;; Generic Neovim configuration.
(set nvim.o.updatetime 500)
(set nvim.o.timeoutlen 500)
(set nvim.o.sessionoptions "blank,curdir,folds,help,tabpages,winsize")
(set nvim.o.inccommand :split)

(nvim.ex.set :number)
(nvim.ex.set :relativenumber)

;; this causes some intermittent underlinings
;(nvim.ex.set :spell)
(nvim.ex.set :list)

;; Reserve column for signs to prevent indenting while editing.
(nvim.ex.set "signcolumn=yes:1")

;; (some) taken from liuchengxu/vim-better-default
(nvim.ex.set "ignorecase")     ; Case insensitive search
(nvim.ex.set "smartcase")      ; ... but case sensitive when uc present
(nvim.ex.set "scrolljump=5")   ; Line to scroll when cursor leaves screen
(nvim.ex.set "scrolloff=3")    ; Minumum lines to keep above and below cursor
(nvim.ex.set "nowrap")         ; Do not wrap long lines
(nvim.ex.set "shiftwidth=2")   ; Use indents of 2 spaces
(nvim.ex.set "tabstop=2")      ; An indentation every two columns
(nvim.ex.set "softtabstop=2")  ; Let backspace delete indent
(nvim.ex.set "expandtab")      ; Tabs are spaces, not tabs
(nvim.ex.set "splitright")     ; Puts new vsplit windows to the right of the current
(nvim.ex.set "splitbelow")     ; Puts new split windows to the bottom of the current
(nvim.ex.set "autowrite")      ; Automatically write a file when leaving a modified buffer
(nvim.ex.set "mousehide")      ; Hide the mouse cursor while typing
(nvim.ex.set "hidden")         ; Allow buffer switching without saving
(nvim.ex.set "t_Co=256")       ; Use 256 colors
(nvim.ex.set "showcmd")        ; Show partial commands in status line and Selected characters/lines in visual mode
(nvim.ex.set "showmatch")      ; Show matching brackets/parentthesis
(nvim.ex.set "report=0")       ; Always report changed lines
(nvim.ex.set "linespace=0")    ; No extra spaces between rows
(nvim.ex.set "pumheight=20")   ; Avoid the pop up menu occupying the whole screen

; http://stackoverflow.com/questions/6427650/vim-in-tmux-background-color-changes-when-paging/15095377#15095377
(nvim.ex.set "t_ut=")

(nvim.ex.set "winminheight=0")
(nvim.ex.set "wildmode=longest:full,full") ; Expand to the longest, then to the next full match

; https://stackoverflow.com/a/54786409
(nvim.ex.let "&listchars=\"tab:→ ,trail:·,extends:↷,precedes:↶\"")

(nvim.ex.set "whichwrap+=<,>,h,l") ; Allow backspace and cursor keys to cross line boundaries

(nvim.ex.set "fileencodings=utf-8,ucs-bom,gb18030,gbk,gb2312,cp936")

(nvim.ex.set "wildignore+=*swp,*.class,*.pyc,*.png,*.jpg,*.gif,*.zip")
(nvim.ex.set "wildignore+=*/tmp/*,*.o,*.obj,*.so") ; Unix
(nvim.ex.set "wildignore+=*\\tmp\\*,*.exe") ; Windows

; Visual shifting (does not exit Visual mode)
(nvim.set_keymap :v :< :<gv {:noremap true})
(nvim.set_keymap :v :> :>gv {:noremap true})

;; TODO: check if needed
; (nvim.ex.highlight "clear SignColumn") ; SignColumn should match background

(nvim.ex.set "clipboard+=unnamed") ; Synchronize w/ the system clipboard

(nvim.ex.set "nobackup")
(nvim.ex.set "noswapfile")
(nvim.ex.set "nowritebackup")

(set nvim.o.directory "/tmp//,.")
(set nvim.o.backupdir "/tmp//,.")
(set nvim.o.undodir (.. (nvim.fn.stdpath "data") "/undo"))
(nvim.ex.set "undofile") ; Persistent undo
(nvim.ex.set "undolevels=1000") ; Maximum number of changes that can be undone
(nvim.ex.set "undoreload=10000") ; Maximum number lines to save for undo on a buffer reload

(nvim.set_keymap :c :<C-h> :<BS> {:noremap true})
(nvim.set_keymap :c :<C-j> :<Down> {:noremap true})
(nvim.set_keymap :c :<C-k> :<Up> {:noremap true})
(nvim.set_keymap :c :<C-b> :<Left> {:noremap true})
(nvim.set_keymap :c :<C-f> :<Right> {:noremap true})
(nvim.set_keymap :c :<C-a> :<Home> {:noremap true})
(nvim.set_keymap :c :<C-e> :<End> {:noremap true})
(nvim.set_keymap :c :<C-d> :<Delete> {:noremap true})

;; Create a file as soon as you edit it. This also fixes ESLint errors on newly created files.
;; https://learnvimscriptthehardway.stevelosh.com/chapters/12.html
(nvim.ex.autocmd "BufNewFile * :write")

;; Fixes `Mark has invalid line number` when jumping back to netrw using CTRL-O.
;; https://github.com/neovim/neovim/issues/24721
(set nvim.g.netrw_keepj "keepj")
