# If Zsh is launched as a login shell, then it’ll source ~/.zshenv which will
# reset PATH to a sensible default. Next, it’ll source /etc/zprofile which will
# run path_helper and set up the default PATH according to the usual macOS
# rules.
# More info: https://checkoway.net/musings/nix/
[[ -o login ]] && export PATH='/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin'
