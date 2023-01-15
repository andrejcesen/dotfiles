function fish_user_key_bindings
  fish_vi_key_bindings

  if test -e "$(brew --prefix)/opt/fzf/shell/key-bindings.fish" >/dev/null
    source "$(brew --prefix)/opt/fzf/shell/key-bindings.fish"
  end

  if type -q fzf_key_bindings
    fzf_key_bindings
  end

  for mode in insert default visual
    bind -M $mode \cf forward-char # Enable <C-F> in vi-bindings.
    # If a script produces output, it should finish by calling
    # `commandline -f repaint` to tell fish that a repaint is in order.
    bind -M $mode \co 'tmux-sessionizer; commandline -f repaint'
  end

end
