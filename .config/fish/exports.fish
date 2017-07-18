set -x PATH "$HOME/.local/bin" $PATH

# set JAVA_HOME to a preferred JVM
set -x JAVA_HOME (/usr/libexec/java_home)

# vim as default
set -x EDITOR vim

# Don’t clear the screen after quitting a manual page
set -x MANPAGER "less -X"

set -x HOMEBREW_CASK_OPTS "--appdir=/Applications"
