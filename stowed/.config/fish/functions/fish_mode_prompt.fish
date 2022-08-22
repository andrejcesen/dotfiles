function fish_mode_prompt --description 'Displays the current mode'
  if test "$fish_key_bindings" = "fish_vi_key_bindings"
    switch $fish_bind_mode
      case default
        set_color red
        # echo 🅽
        echo N
      case insert
        set_color green
        # echo 🅸
        echo N
      case replace_one
        set_color green
        # echo 🆁
        echo R
      case visual
        set_color brmagenta
        # echo 🆅
        echo V
    end
    set_color normal
    printf " "
  end
end
