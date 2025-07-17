#!/usr/bin/env bash

# -x  Print commands and their arguments as they are executed.
# -e  Exit immediately if a command exits with a non-zero status.
set -xe

# Downloads cask versions. Allows to target specific version, eg. `brew install --cask temurin21`
brew tap homebrew/cask-versions

# brew cask
brew install --cask \
  temurin21 \
  alfred \
  android-studio \
  brave-browser \
  dash \
  fork \
  kitty \
  paw \
  rectangle \
  sloth \
  spotify \
  tomatobar \
  transmission \
  visual-studio-code \
  vlc \
  zoom

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
  tldr \
  entr \
  tree \
  gnupg \
  pinentry-mac \
  git \
  git-delta \
  gh \
  node@20 \
  orbstack \
  ruby \
  imagemagick \
  yt-dlp \
  jq \
  gron \
  xmlformat \
  watchman \
  direnv \
  clojure/tools/clojure \
  clojure-lsp/brew/clojure-lsp-native \
  borkdude/brew/babashka \
  efm-langserver \
  neovim \
  tmux \
  mosh \
  stow \
  mas

# Xcode
if ! command -v gem &> /dev/null
then
  PATH="/opt/homebrew/opt/ruby/bin:$PATH"
  PATH="$(/opt/homebrew/opt/ruby/bin/gem env gemdir):$PATH"
fi
gem install xcode-install
xcversion install "$(xcversion list | grep -E "^[^ ]+\$" | tail -n 1)"

# npm
npm install --global \
  @fsouza/prettierd \
  trash-cli \
  typescript \
  typescript-language-server \
  vscode-langservers-extracted \
  pyright

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

# rustup
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
# rust-analyzer
# https://rust-analyzer.github.io/manual.html#installation
curl -L https://github.com/rust-lang/rust-analyzer/releases/latest/download/rust-analyzer-aarch64-apple-darwin.gz | gunzip -c - > ~/.local/bin/rust-analyzer
chmod +x ~/.local/bin/rust-analyzer
