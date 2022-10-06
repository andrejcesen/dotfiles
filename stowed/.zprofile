# Since this is sourced after path_helper is run (/etc/zprofile), the
# directories added will not be rearranged.

# Setup Homebrew paths
eval "$(/opt/homebrew/bin/brew shellenv)"

# Nix
if [[ -f '/nix/var/nix/profiles/default/etc/profile.d/nix-daemon.sh' ]]; then
  source '/nix/var/nix/profiles/default/etc/profile.d/nix-daemon.sh'
fi
