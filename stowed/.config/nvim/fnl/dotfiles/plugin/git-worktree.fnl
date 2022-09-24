(module dotfiles.plugin.git-worktree
  {autoload {a aniseed.core
             nvim aniseed.nvim}})

(defn- on-tree-change [op {: prev_path : path}]
  nil)

(let [(ok? git-worktree) (pcall require :git-worktree)]
  (when ok?
    (git-worktree.on_tree_change (fn [op meta]
                                   ;; Always resolve to absolute path.
                                   (let [absolute-path (git-worktree.get_worktree_path meta.path)]
                                     (on-tree-change op (a.merge meta {:path absolute-path})))))))
