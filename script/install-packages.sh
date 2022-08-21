#!/usr/bin/env bash

# -x  Print commands and their arguments as they are executed.
# -e  Exit immediately if a command exits with a non-zero status.
set -xe

# brew
brew install \
  fish \
  shellcheck \
  coreutils \
  findutils \
  moreutils \
  gnu-sed \
  grep \
  ripgrep \
  rename \
  fzf \
  z \
  bat \
  entr \
  tree \
  gnupg \
  pinentry-mac \
  git \
  git-delta \
  gh \
  node@14 \
  ruby \
  imagemagick \
  youtube-dl \
  jq \
  gron \
  xmlformat \
  watchman \
  direnv \
  openjdk@11 \
  clojure/tools/clojure \
  clojure-lsp/brew/clojure-lsp-native \
  borkdude/brew/babashka \
  neovim \
  tmux \
  mosh \
  stow \
  mas

brew link node@14

# brew cask
brew install --cask \
  alfred \
  android-studio \
  brave-browser \
  docker \
  fork \
  intellij-idea-ce \
  jetbrains-toolbox \
  paw \
  spotify \
  transmission \
  visual-studio-code \
  vlc \
  zoom

# Xcode
if ! command -v gem &> /dev/null
then
  PATH="/opt/homebrew/opt/ruby/bin:$PATH"
  PATH="$(/opt/homebrew/opt/ruby/bin/gem env gemdir):$PATH"
fi
gem install xcode-install
xcversion install "$(xcversion list | grep -E "^[^ ]+\$" | tail -n 1)"

# npm
npm install --global trash-cli
npm install --global pyright

# VSCode
code --install-extension arcticicestudio.nord-visual-studio-code
code --install-extension betterthantomorrow.calva
code --install-extension vscodevim.vim

# mas
mas install 803453959 # Slack
mas install 403504866 # PCalc
mas install 1365531024 # 1Blocker
mas install 1055273043 # PDF expert
mas install 414528154 # Screenfloat
mas install 441258766 # Magnet
mas install 409201541 # Pages
mas install 409203825 # Numbers
mas install 409183694 # Keynote
mas install 424389933 # Final Cut Pro
mas install 424390742 # Compressor
mas install 434290957 # Motion
mas install 634148309 # Logic Pro
mas signout; echo "Sign in to App Store and press any key..."; read -n 1
mas install 1289583905 # Pixelmator Pro
mas install 1136220934 # Infuse 7

# YNAB 4 (64-bit)
echo | /bin/sh -c "$(curl -fsSL https://gitlab.com/bradleymiller/Y64/raw/master/install)"

