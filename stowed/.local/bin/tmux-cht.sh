#!/usr/bin/env bash
selected=`cat ~/.tmux-cht-languages ~/.tmux-cht-command | fzf`
if [[ -z $selected ]]; then
    exit 0
fi

read -rp "Enter Query: " query

if grep -qs "$selected" ~/.tmux-cht-languages; then
    query=`echo "$query" | tr ' ' '+'`
    curl -s "cht.sh/$selected/$query?T" | bat --paging=always --language "$selected"
else
    curl -s "cht.sh/$selected~$query?T" | bat --paging=always --language sh
fi
