set -x PATH "$HOME/.local/bin" $PATH

# set JAVA_HOME to a preferred JVM
set -x JAVA_HOME (/usr/libexec/java_home ^/dev/null)

# vim as default
set -x EDITOR vim

# Don’t clear the screen after quitting a manual page
set -x MANPAGER "less -X"

set -x HOMEBREW_CASK_OPTS "--appdir=/Applications"
# set -x NVM_DIR "$HOME/.nvm"

# Android (test to avoid warnings on nonexisting paths)
set -x ANDROID_HOME "$HOME/Library/Android/sdk"
test -d "$ANDROID_HOME/tools"; and set -x PATH "$ANDROID_HOME/tools" $PATH
test -d "$ANDROID_HOME/platform-tools"; and set -x PATH "$ANDROID_HOME/platform-tools" $PATH