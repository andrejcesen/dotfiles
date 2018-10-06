#!/bin/bash


# to maintain cask ....
#     brew update && brew upgrade brew-cask && brew cleanup && brew cask cleanup`

# upgrade outdated apps
#     brew cu
brew tap buo/cask-upgrade


# Entertainment
brew cask install vlc
brew cask install spotify
brew cask install beamer
brew cask install transmission

# Development
brew cask install caskroom/versions/dash3
brew cask install jetbrains-toolbox
brew cask install paw
brew cask install visual-studio-code
brew cask install atom
brew cask install docker
brew cask install xquartz
brew cask install fork

# General
brew cask install alfred
brew cask install google-chrome
brew cask install caskroom/versions/firefox-esr
