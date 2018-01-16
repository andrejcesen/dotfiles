# copy paste this file in bit by bit.
# don't run it.
  echo "do not run this script in one go. hit ctrl-c NOW"
  read -n 1


##############################################################################################################
###  backup old machine's key items

mkdir -p ~/migration/home
cd ~/migration

# what is worth reinstalling?
brew leaves      		> brew-list.txt    # all top-level brew installs
brew cask list 			> cask-list.txt
npm list -g --depth=0 	> npm-g-list.txt
code --list-extensions  > vscode-list.txt


# then compare brew-list to what's in `brew.sh`
#   comm <(sort brew-list.txt) <(sort brew.sh-cleaned-up)

# let's hold on to these

cp ~/.extra ~/migration/home
cp ~/.z ~/migration/home

cp -R ~/.ssh ~/migration/home
cp -R ~/.gnupg ~/migration/home

cp ~/Library/Preferences/com.tinyspeck.slackmacgap.plist ~/migration

cp -R ~/Library/Services ~/migration # automator stuff

cp -R ~/Documents ~/migration

cp ~/.bash_history ~/migration # back it up for fun?

cp ~/.gitconfig.local ~/migration

cp ~/.z ~/migration # z history file.

# software licenses like sublimetext


### end of old machine backup
##############################################################################################################



##############################################################################################################
### XCode Command Line Tools
#      thx https://github.com/alrra/dotfiles/blob/ff123ca9b9b/os/os_x/installs/install_xcode.sh

if ! xcode-select --print-path &> /dev/null; then

    # Prompt user to install the XCode Command Line Tools
    xcode-select --install &> /dev/null

    # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

    # Wait until the XCode Command Line Tools are installed
    until xcode-select --print-path &> /dev/null; do
        sleep 5
    done

    print_result $? 'Install XCode Command Line Tools'

    # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

    # Point the `xcode-select` developer directory to
    # the appropriate directory from within `Xcode.app`
    # https://github.com/alrra/dotfiles/issues/13

    sudo xcode-select -switch /Applications/Xcode.app/Contents/Developer
    print_result $? 'Make "xcode-select" developer directory point to Xcode'

    # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

    # Prompt user to agree to the terms of the Xcode license
    # https://github.com/alrra/dotfiles/issues/10

    sudo xcodebuild -license
    print_result $? 'Agree with the XCode Command Line Tools licence'

fi
###
##############################################################################################################



##############################################################################################################
### homebrew!

# (if your machine has /usr/local locked down (like google's), you can do this to place everything in ~/.homebrew
# mkdir $HOME/.homebrew && curl -L https://github.com/mxcl/homebrew/tarball/master | tar xz --strip 1 -C $HOME/.homebrew
# export PATH=$HOME/.homebrew/bin:$HOME/.homebrew/sbin:$PATH
/usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"

# install all the things
./brew.sh
./brew-cask.sh

### end of homebrew
##############################################################################################################




##############################################################################################################
### install of common things
###

# github.com/jamiew/git-friendly
# the `push` command which copies the github compare URL to my clipboard is heaven
bash < <( curl https://raw.githubusercontent.com/jamiew/git-friendly/master/install.sh)


# Type `git open` to open the GitHub page or website for a repository.
npm install -g git-open

# fancy listing of recent branches
npm install -g git-recent

# sexy git diffs
npm install -g diff-so-fancy

# trash as the safe `rm` alternative
npm install --global trash-cli

# install better nanorc config
# https://github.com/scopatz/nanorc
# curl https://raw.githubusercontent.com/scopatz/nanorc/master/install.sh | sh


# for the c alias (syntax highlighted cat)
sudo easy_install Pygments


# add bash 4 (installed by homebrew)
BASHPATH=$(brew --prefix)/bin/bash
sudo bash -c "echo $BASHPATH >> /etc/shells"

# add fish shell and set as default (installed by homebrew)
FISHPATH=$(brew --prefix)/bin/fish
sudo bash -c "echo $FISHPATH >> /etc/shells"
chsh -s $FISHPATH # will set for current user only.

# echo $BASH_VERSION # should be 4.x not the old 3.2.X
# Later, confirm iterm settings aren't conflicting.


# iterm with more margin! http://hackr.it/articles/prettier-gutter-in-iterm-2/
#   (admittedly not as easy to maintain)


###
##############################################################################################################



# improve perf of git inside of chromium checkout
# https://chromium.googlesource.com/chromium/src/+/master/docs/mac_build_instructions.md

# sudo sysctl kern.maxvnodes=$((512*1024))
# echo kern.maxvnodes=$((512*1024)) | sudo tee -a /etc/sysctl.conf

# speed up git status
# git config status.showuntrackedfiles no
# git update-index --untracked-cache


##############################################################################################################
### remaining configuration
###

# go read mathias, paulmillr, gf3, alraa's dotfiles to see what's worth stealing.

# prezto and antigen communties also have great stuff
#   github.com/sorin-ionescu/prezto/blob/master/modules/utility/init.zsh

# set up osx defaults
#   maybe something else in here https://github.com/hjuutilainen/dotfiles/blob/master/bin/osx-user-defaults.sh
sh .macos

# setup and run Rescuetime!

###
##############################################################################################################


# Network Location Changer (https://github.com/rimar/wifi-location-changer)
# first create network locations as WiFi names without spaces i.e. SomeNetwork, then:
cp init/locationchanger /usr/local/bin && chmod +x /usr/local/bin/locationchanger
mkdir ~/Library/LaunchAgents
cp init/LocationChanger.plist ~/Library/LaunchAgents/
# launch daemon
launchctl load ~/Library/LaunchAgents/LocationChanger.plist


# Force RGB mode in MacOS (for external display) (http://www.mathewinkson.com/2013/03/force-rgb-mode-in-mac-os-x-to-fix-the-picture-quality-of-an-external-monitor/comment-page-13#comment-15886)
# 1. Connect with external display
# 2. Close the MacBook's lid (so only external display is active)
cp init/patch-edid.rb ~ && ruby patch-edid.rb
# 3. boot into recovery mode (Cmd+R during boot)
cp -r /Volumes/Macintosh\ HD/Users/andrejcesen/EDID-Fix/DisplayVendorID-* /Volumes/Macintosh\ HD/System/Library/Displays/Contents/Resources/Overrides/


##############################################################################################################
### symlinks to link dotfiles into ~/
###

#   move git credentials into ~/.gitconfig.local    	http://stackoverflow.com/a/13615531/89484
#   now .gitconfig can be shared across all machines and only the .local changes

# symlink it up!
./link_dotfiles.sh

# Fish completions
curl -Lo ~/.config/fish/completions/docker.fish --create-dirs https://raw.github.com/barnybug/docker-fish-completion/master/docker.fish

###
##############################################################################################################
