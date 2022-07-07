# Navigation
function ..    ; cd .. ; end
function ...   ; cd ../.. ; end
function ....  ; cd ../../.. ; end
function ..... ; cd ../../../.. ; end

# Shortcuts
alias g="git"
alias v="nvim"

alias ls="ls -G"
alias ll="ls -lhG"
alias la="ls -lahG"

alias main="git switch main 2>/dev/null || git switch master"
alias master="main"

# Networking. IP address, dig, DNS
alias ip="dig +short myip.opendns.com @resolver1.opendns.com"
alias dig="dig +nocmd any +multiline +noall +answer"

# Recursively delete `.DS_Store` files
alias cleanup_dsstore="find . -name '*.DS_Store' -type f -ls -delete"
# Purge Xcode cache the right way: https://lapcatsoftware.com/articles/DerivedData.html
alias cleanup_xcode_deriveddata="osascript -e 'tell application \"Finder\" to move POSIX file \"$HOME/Library/Developer/Xcode/DerivedData\" to trash'"
