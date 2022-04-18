# Backup old machine's key items
mkdir -p ~/migration/home/
mkdir -p ~/migration/Library/"Application Support"/

# Backup some dotfiles likely not under source control
cp -Rp \
  ~/.extra.fish \
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

cp -Rp ~/Library/Fonts ~/migration/Library/ # all those fonts you've installed
cp -Rp ~/Library/Spelling/*.{aff,dic} ~/migration/Library/Spelling # spelling dictionaries

# Editor settings & plugins
cp -Rp ~/Library/Application\ Support/Code* ~/migration/Library/"Application Support"

