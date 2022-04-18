# Nord Color Theme
# https://github.com/arcticicestudio/nord-terminal-app/issues/1#issue-197386036

# Normal
set -l nord1   "black"
set -l nord11  "red"
set -l nord14  "green"
set -l nord13  "yellow"
set -l nord10  "blue"
set -l nord15  "magenta"
set -l nord8   "cyan"
set -l nord5   "white"

# Bright
set -l nord3   "brblack"
set -l nord9   "brblue"
set -l nord7   "brcyan"
set -l nord6   "brwhite"
# Same as normal colors
# set -l nord11  "brred"
# set -l nord14  "brgreen"
# set -l nord13  "bryellow"
# set -l nord15  "brmagenta"

# Fish theme
set -g fish_color_command $nord9
set -g fish_color_normal normal
set -g fish_color_redirection $nord15
set -g fish_color_error $nord13
set -g fish_color_end $nord8
set -g fish_color_quote $nord14
set -g fish_color_param $nord6
set -g fish_color_comment $nord3
set -g fish_color_match --background=brblue
set -g fish_color_selection white --bold --background=brblack
set -g fish_color_search_match bryellow --background=brblack
set -g fish_color_history_current --bold
set -g fish_color_operator $nord8
set -g fish_color_escape $nord8
set -g fish_color_cwd green
set -g fish_color_cwd_root red
set -g fish_color_valid_path --underline
set -g fish_color_autosuggestion $nord3
set -g fish_color_user brgreen
set -g fish_color_host normal
set -g fish_color_cancel -r
set -g fish_pager_color_completion normal
set -g fish_pager_color_description $nord3
set -g fish_pager_color_prefix normal --bold --underline
set -g fish_pager_color_progress $nord1 --background=$nord8


# highlighting inside manpages and elsewhere
# https://en.wikipedia.org/wiki/ANSI_escape_code
# https://serverfault.com/a/35272
set -gx LESS_TERMCAP_mb \e'[01;31m'       # begin blinking (31=red)
set -gx LESS_TERMCAP_md \e'[01;34m'       # begin bold (34=blue)
set -gx LESS_TERMCAP_me \e'[0m'           # end mode
set -gx LESS_TERMCAP_se \e'[0m'           # end standout-mode
set -gx LESS_TERMCAP_so \e'[0;97;104m'     # begin standout-mode - info box
                                          # (fg: 97=brwhite, bg: 104=brblue)
set -gx LESS_TERMCAP_ue \e'[0m'           # end underline
set -gx LESS_TERMCAP_us \e'[4;36m'        # begin underline (36=cyan)
