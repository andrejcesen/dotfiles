(module dotfiles.plugin.git-worktree
  {autoload {a aniseed.core
             nvim aniseed.nvim}})

(defn starts-with? [s substr]
  ;; http://lua-users.org/wiki/StringLibraryTutorial
  ;; Start at index 1 and turn off pattern matching.
  (string.find s substr 1 true))

(defn codescene? [path]
  (starts-with? path nvim.env.CODESCENE_HOME))

(defn- build-codescene [path]
   (string.format ":silent !tmux-codescene tmux '%s'" path))

(defn- on-tree-change [op {: prev_path : path}]
  (when
    (and (codescene? path)
         (or (= op "create")
             (= op "switch"))) (nvim.command (build-codescene path))))

(let [(ok? git-worktree) (pcall require :git-worktree)]
  (when ok?
    (git-worktree.on_tree_change (fn [op meta]
                                   ;; Always resolve to absolute path.
                                   (let [absolute-path (git-worktree.get_worktree_path meta.path)]
                                     (on-tree-change op (a.merge meta {:path absolute-path})))))))
