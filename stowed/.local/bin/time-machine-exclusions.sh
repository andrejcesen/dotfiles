#!/usr/bin/env bash

# https://programmingarehard.com/2022/03/03/time-machine-for-developers.html/
# https://www.heissenberger.at/en/blog/macos-exclude-node_modules-folder-from-time-machine/

# TODO:
# * View exclusions
# * Remove exclusions
# * Automating via cron

find "$HOME/Projects" \
    -type d \( -name node_modules -o \
               -name Pods -o \
               -name .cache -o \
               -name .shadow-cljs \) \
    -prune \
    -exec tmutil addexclusion {} \; \
    -exec tmutil isexcluded {} \;

tmutil addexclusion "/Users/andrejcesen/Library/Application Support/Spotify/PersistentCache"
