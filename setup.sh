#!/usr/bin/env zsh

HOMEDIR="Users"

if [[ $(uname) != "Darwin" ]] ; then
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
    [$(pwd)/.zshenv]=/$HOMEDIR/$(whoami)/.zshenv
    [$(pwd)/.profile]=/$HOMEDIR/$(whoami)/.profile
    [$(pwd)/nvim]=/$HOMEDIR/$(whoami)/.config/nvim
    [$(pwd)/.bunfig.toml]=/$HOMEDIR/$(whoami)/.bunfig.toml
    [$(pwd)/alacritty]=/$HOMEDIR/$(whoami)/.config/alacritty
)

# create symbolic links for config files
echo "~~~ LINKING FILES... ~~~"
for key value in ${(kv)DOTFILES}; do
    if [[ -L $value ]] ; then # if symlink already exists...
	    echo "Unlinking $value"
	    rm $value # remove!
    elif [[ -f $value ]] ; then # if a file already exists...
        echo "Removing $value"
        rm $value # remove!
    elif [[ -d $value ]] ; then # if the target is a directory...
        echo "Removing $value directory"
        rm -rf $value # remove!
    fi
    echo "Creating link for:"
    echo $key
    echo "@"
    echo $value
    ln -s $key $value # create symlink
    echo "";
done

if [[ ! -f /$HOMEDIR/$(whoami)/.hushlogin ]] ; then
    echo "Creating ~/.hushlogin"
    touch /$HOMEDIR/$(whoami)/.hushlogin
fi

echo Done!
