# Best to run this manually.

# Backup old machine's key items
mkdir -p ~/migration/home/

# Backup some dotfiles likely not under source control
cp -Rp \
  ~/.local-config.fish \
  ~/.gitconfig.local \
  ~/.gitignore \
  ~/.gnupg \
  ~/.ssh \
  ~/.z \
    ~/migration/home

cp -Rp \
  ~/Documents \
  ~/Projects \
    ~/migration

mkdir -p ~/migration/Library/
cp -Rp ~/Library/Fonts ~/migration/Library/ # all those fonts you've installed
cp -Rp ~/Library/Spelling/*.{aff,dic} ~/migration/Library/Spelling # spelling dictionaries

# Backup Bear notes
mkdir -p "$HOME/migration/Library/Group Containers/9K33E3U3T4.net.shinyfrog.bear/" 
cp -Rp   "$HOME/Library/Group Containers/9K33E3U3T4.net.shinyfrog.bear/Application Data" \
         "$HOME/migration/Library/Group Containers/9K33E3U3T4.net.shinyfrog.bear/"

# Editor settings & plugins
mkdir -p ~/migration/Library/"Application Support"/
cp -Rp ~/Library/Application\ Support/Code* ~/migration/Library/"Application Support"
