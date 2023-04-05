function fish_user_key_bindings
  # Execute this once per mode that emacs bindings should be used in
  fish_default_key_bindings -M insert

  # Then execute the vi-bindings so they take precedence when there's a conflict.
  # Without --no-erase fish_vi_key_bindings will default to
  # resetting all bindings.
  # The argument specifies the initial mode (insert, "default" or visual).
  fish_vi_key_bindings --no-erase insert

  if test -e "$(brew --prefix)/opt/fzf/shell/key-bindings.fish" >/dev/null
    source "$(brew --prefix)/opt/fzf/shell/key-bindings.fish"
  end

  if type -q fzf_key_bindings
    fzf_key_bindings
  end

  for mode in insert default visual
    # If a script produces output, it should finish by calling
    # `commandline -f repaint` to tell fish that a repaint is in order.
    bind -M $mode \co 'tmux-sessionizer; commandline -f repaint'
  end

end
