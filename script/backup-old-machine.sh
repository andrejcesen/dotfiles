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

cd ~ || exit
rsync -R .local/state/nvim/shada/main.shada ~/migration/home
rsync -R .local/share/fish/fish_history ~/migration/home
rsync -R .m2/settings.xml ~/migration/home

mkdir -p ~/migration/Library/
cp -Rp ~/Library/Fonts ~/migration/Library/ # all those fonts you've installed
cp -Rp ~/Library/Spelling/*.{aff,dic} ~/migration/Library/Spelling # spelling dictionaries

# 1. Make sure to close Bear app.
# 2. Backup Bear notes
mkdir -p "$HOME/migration/Library/Group Containers/9K33E3U3T4.net.shinyfrog.bear/" 
cp -Rp   "$HOME/Library/Group Containers/9K33E3U3T4.net.shinyfrog.bear/Application Data" \
         "$HOME/migration/Library/Group Containers/9K33E3U3T4.net.shinyfrog.bear/"
# 3. Also backup to .bear2bk file in ~/Documents/2-Areas
shortcuts run "Backup Bear Notes"

# Editor settings & plugins
mkdir -p ~/migration/Library/"Application Support"/
cp -Rp ~/Library/Application\ Support/Code* ~/migration/Library/"Application Support"

cp -Rp \
  ~/Documents \
  ~/Projects \
    ~/migration
