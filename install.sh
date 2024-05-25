#!/bin/zsh
set -euo pipefail

if [[ -z $STOW_FOLDERS ]]; then
    echo "setting"
    STOW_FOLDERS="fd,nvim,ripgrep,tmux,zsh"
fi

if [[ -z $DOTFILES ]]; then
    DOTFILES=$HOME/.dotfiles
fi

pushd "$DOTFILES"
for folder in $(echo "$STOW_FOLDERS" | sed "s/,/ /g"); do
    echo "stow $folder"
    stow -D "$folder"
    stow "$folder"
done
popd
