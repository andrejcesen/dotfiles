#!/usr/bin/env bash

# -x  Print commands and their arguments as they are executed.
# -e  Exit immediately if a command exits with a non-zero status.
set -xe

# Homebrew
test -d /opt/homebrew && eval "$(/opt/homebrew/bin/brew shellenv)"

if ! command -v brew &> /dev/null
then
  bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

  test -d /opt/homebrew && eval "$(/opt/homebrew/bin/brew shellenv)"
  echo "eval \"\$($(brew --prefix)/bin/brew shellenv)\"" >>~/.zprofile
fi

# Install
./script/install-packages.sh
stow --target="$HOME" stowed

# Set fish as a default shell
FISHPATH=$(which fish)
sudo sh -c "echo $FISHPATH >> /etc/shells"
chsh -s "$FISHPATH"

~/.config/nvim/sync.sh

./script/macos.sh
