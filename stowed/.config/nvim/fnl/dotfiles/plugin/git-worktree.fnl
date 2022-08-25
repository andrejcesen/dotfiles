(module dotfiles.plugin.git-worktree
  {autoload {a aniseed.core
             nvim aniseed.nvim}})

(defn pitch? [path] (string.find
                      path
                      nvim.env.PITCH_HOME
                      nil    ;; Start at index 1 (default).
                      true)) ;; Turn off pattern-matching: https://stackoverflow.com/a/6077464/18714042

(defn- prepare-pitch [path]
  (string.format ":silent !prepare-pitch '%s'" path path))

(defn- prepare-and-build-pitch [path]
  (string.format ":silent !prepare-pitch '%s' && tmux-pitch tmux '%s'" path path))

(defn- on-tree-change [op {: prev_path : path}]
  (when
    (and (pitch? path)
         (= op "create")) (nvim.command (prepare-and-build-pitch path)))
  (when
    (and (pitch? path)
         (= op "switch")) (nvim.command (prepare-pitch path))))

(let [(ok? git-worktree) (pcall require :git-worktree)]
  (when ok?
    (git-worktree.on_tree_change (fn [op meta]
                                   ;; Always resolve to absolute path.
                                   (let [absolute-path (git-worktree.get_worktree_path meta.path)]
                                     (on-tree-change op (a.merge meta {:path absolute-path})))))))
