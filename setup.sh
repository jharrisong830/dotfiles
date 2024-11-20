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
echo "~~~ LINKING FILES... ~~~"
for key value in ${(kv)DOTFILES}; do
    if [[ -f $value ]]; then # if symlink already exists...
	    echo "Unlinking $value"
	    rm $value # remove!
    fi
    echo "Creating link for:"
    echo $key
    echo "@"
    echo $value
    ln -s $key $value # create symlink
    echo
done;

if [[ ! -f /$HOMEDIR/$(whoami)/.hushlogin ]]; then
    echo "Creating ~/.hushlogin"
    touch /$HOMEDIR/$(whoami)/.hushlogin
fi

