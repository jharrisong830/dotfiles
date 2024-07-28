#!/usr/bin/env zsh

typeset -A DOTFILES=(
    # [dotfiles repo loc]=loc on system
    [$(pwd)/.gitconfig]=/Users/$(whoami)/.gitconfig
    [$(pwd)/.npmrc]=/Users/$(whoami)/.npmrc
    [$(pwd)/.prettierrc]=/Users/$(whoami)/.prettierrc
    [$(pwd)/.prettierignore]=/Users/$(whoami)/.prettierignore
    [$(pwd)/.zshrc]=/Users/$(whoami)/.zshrc
    [$(pwd)/.zprofile]=/Users/$(whoami)/.zprofile
    [$(pwd)/nvim]=/Users/$(whoami)/.config/nvim
)

# create symbolic links for config files

for key value in ${(kv)DOTFILES}; do
    if [[ -f $value ]]; then # if symlink already exists...
	echo removed!!
	rm $value # remove!
    fi
    echo linking!
    ln -s $key $value # create symlink
done;

