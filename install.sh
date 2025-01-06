#!/bin/zsh
set -euo pipefail

if [[ -z ${STOW_FOLDERS+unset_var} ]]; then
    echo "setting"
    STOW_FOLDERS="fd,ghostty,nvim,ripgrep,tmux,zsh"
fi

if [[ -z ${DOTFILES+unset_var} ]]; then
    DOTFILES=$HOME/.dotfiles
fi

pushd "$DOTFILES"
for folder in $(echo "$STOW_FOLDERS" | sed "s/,/ /g"); do
    echo "stow $folder"
    stow -D "$folder"
    stow "$folder"
done
popd
