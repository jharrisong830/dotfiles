#!/usr/bin/env zsh

HOMEDIR="Users"

if [[ $(uname) != "Darwin" ]]; then
    HOMEDIR="home"
fi

typeset -A DOTFILES=(
    # [dotfiles repo loc]=loc on system
    [$(pwd)/.gitconfig]=/$HOMEDIR/$(whoami)/.gitconfig
    [$(pwd)/.npmrc]=/$HOMEDIR/$(whoami)/.npmrc
    [$(pwd)/.prettierrc]=/$HOMEDIR/$(whoami)/.prettierrc
    [$(pwd)/.prettierignore]=/$HOMEDIR/$(whoami)/.prettierignore
    [$(pwd)/.zshrc]=/$HOMEDIR/$(whoami)/.zshrc
    [$(pwd)/.zprofile]=/$HOMEDIR/$(whoami)/.zprofile
    [$(pwd)/nvim]=/$HOMEDIR/$(whoami)/.config/nvim
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

if [[ ! -f /$HOMEDIR/$(whoami)/.hushlogin ]]; then
    touch /$HOMEDIR/$(whoami)/.hushlogin
fi

