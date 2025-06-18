(module dotfiles.plugin.git-worktree
  {autoload {a aniseed.core
             nvim aniseed.nvim
             plenary plenary}})

(defn starts-with? [s substr]
  ;; http://lua-users.org/wiki/StringLibraryTutorial
  ;; Start at index 1 and turn off pattern matching.
  (string.find s substr 1 true))

(defn codescene? [path]
  (starts-with? path nvim.env.CODESCENE_DEV_HOME))

(defn- build-codescene-cmd [path param]
  (let [cmd (string.format ":silent !tmux-codescene tmux '%s'" path)]
    (if param
      (.. cmd " " param)
      cmd)))

(defn get-absolute-path [path]
  (let [plenary-path (plenary.path:new path)]
    (if (plenary-path:is_absolute)
      path
      (plenary-path:absolute))))

(defn- on-tree-change [type path prev_path]
  (let [absolute-path (get-absolute-path path)]
    (when (codescene? absolute-path)
      (when (= type :create)
        (nvim.command (build-codescene-cmd absolute-path)))
      (when (= type :switch)
        (nvim.command (build-codescene-cmd absolute-path "just-build"))))) )

(let [(hooks-ok? hooks)   (pcall require "git-worktree.hooks")
      (config-ok? config) (pcall require "git-worktree.config")]
  (when (and hooks-ok? config-ok?)
    (hooks.register hooks.type.CREATE (fn [path prev_path]
                                        (on-tree-change :create path prev_path)))
    (hooks.register hooks.type.SWITCH (fn [path prev_path]
                                        (on-tree-change :switch path prev_path)
                                        ;; `cd` to the new path
                                        (hooks.builtins.update_current_buffer_on_switch path prev_path)))))
