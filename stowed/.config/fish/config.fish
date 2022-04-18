set -gx JAVA_HOME (/usr/libexec/java_home)

set -gx ANDROID_HOME $HOME/Library/Android/sdk
fish_add_path --path $ANDROID_HOME/cmdline-tools/latest/bin \
                     $ANDROID_HOME/emulator \
                     $ANDROID_HOME/tools \
                     $ANDROID_HOME/tools/bin \
                     $ANDROID_HOME/platform-tools

# https://stackoverflow.com/a/66556339
fish_add_path --path (/opt/homebrew/opt/ruby/bin/gem env gemdir)/bin \
                     /opt/homebrew/opt/ruby/bin

fish_add_path --path /opt/homebrew/opt/python/libexec/bin

set -gx fish_greeting ""

test -d /opt/homebrew && eval (/opt/homebrew/bin/brew shellenv)

if type -q nvim
  set -gx EDITOR nvim
  set -gx VISUAL nvim
  set -gx MANPAGER "nvim +Man! -c ':set signcolumn='"
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
