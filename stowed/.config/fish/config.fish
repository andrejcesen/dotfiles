# On macOS, the standard set `/usr/bin:/bin:/usr/sbin:/sbin:/usr/local/bin`
# gets prepended to PATH on login shell. Because tmux always runs as a login
# shell, this standard set gets prepended to an already existing PATH 
# (set by Terminal.app running `config.fish` on login), which results in
# `/usr/bin:...:/opt/homebrew/bin` -> system paths coming before homebrew.
#
# More info:
# https://superuser.com/questions/544989/does-tmux-sort-the-path-variable
#
if set -q TMUX && test -x /usr/libexec/path_helper
  # If we're in tmux, we want to build PATH from scratch, so that
  # we control ordering (just as we would in initial login shell).
  # By unsetting env, path_helper will build us a fresh inital PATH
  # and MANPATH.
  eval (env PATH="" MANPATH="" INFOPATH="" /usr/libexec/path_helper -c)
end

test -d /opt/homebrew && eval (/opt/homebrew/bin/brew shellenv)

set -gx JAVA_HOME (/usr/libexec/java_home)

set -gx ANDROID_HOME ~/Library/Android/sdk
fish_add_path --path $ANDROID_HOME/cmdline-tools/latest/bin \
                     $ANDROID_HOME/emulator \
                     $ANDROID_HOME/tools \
                     $ANDROID_HOME/tools/bin \
                     $ANDROID_HOME/platform-tools

# https://stackoverflow.com/a/66556339
fish_add_path --path (/opt/homebrew/opt/ruby/bin/gem env gemdir)/bin \
                     /opt/homebrew/opt/ruby/bin

fish_add_path --path /opt/homebrew/opt/python/libexec/bin
fish_add_path --path ~/.local/bin

set -gx fish_greeting ""

if type -q nvim
  set -gx EDITOR nvim
  set -gx VISUAL nvim
  set -gx MANPAGER "nvim +Man!"
  alias vimdiff="nvim -d"
end

set -gx FZF_DEFAULT_COMMAND "rg --files --hidden --follow -g \"!.git/\" 2> /dev/null"
set -gx FZF_CTRL_T_COMMAND $FZF_DEFAULT_COMMAND

set -gx BAT_THEME 'base16'

source ~/.config/fish/theme.fish
source ~/.config/fish/aliases.fish

# Local config.
if [ -f ~/.config.fish ]
  source ~/.config.fish
end

direnv hook fish | source
