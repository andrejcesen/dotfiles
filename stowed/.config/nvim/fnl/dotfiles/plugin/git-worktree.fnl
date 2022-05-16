(module dotfiles.plugin.git-worktree
  {autoload {a aniseed.core
             nvim aniseed.nvim}})

(defn pitch? [path] (string.find
                      path
                      nvim.env.PITCH_HOME
                      nil    ;; Start at index 1 (default).
                      true)) ;; Turn off pattern-matching: https://stackoverflow.com/a/6077464/18714042

(defn- prepare-pitch [path]
  (let [command (string.format ":silent !prepare-pitch '%s'" path)]
      (nvim.command command)))

(defn- on-tree-change [op {: prev_path : path}]
  (if
    (and (pitch? path)
         (or (= op "create")
             (= op "switch"))) (prepare-pitch path)))

(let [(ok? git-worktree) (pcall require :git-worktree)]
  (when ok?
    (git-worktree.on_tree_change (fn [op meta]
                                   ;; Always resolve to absolute path.
                                   (let [absolute-path (git-worktree.get_worktree_path meta.path)]
                                     (on-tree-change op (a.merge meta {:path absolute-path})))))))
