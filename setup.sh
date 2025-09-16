#!/usr/bin/env zsh

setopt globdots # include dotfiles in globbing

HOMEDIR="Users"

if [[ $(uname) != "Darwin" ]] ; then
    HOMEDIR="home"
fi

typeset -A DOTFILES=(
    # [dotfiles repo loc]=loc on system
    [$(pwd)/.npmrc]=/$HOMEDIR/$(whoami)/.npmrc
    [$(pwd)/.prettierrc]=/$HOMEDIR/$(whoami)/.prettierrc
    [$(pwd)/.prettierignore]=/$HOMEDIR/$(whoami)/.prettierignore
    [$(pwd)/.bunfig.toml]=/$HOMEDIR/$(whoami)/.bunfig.toml
)

function _unlink_target() {
    target=$1

    if [[ -L $target ]] || [[ -f $target ]] ; then
        echo "Deleting $target"
        rm $target
    elif [[ -d $target ]] ; then
        echo "Deleting directory $target"
        rm -rf $target
    fi
}

function _link_dotfiles() {
    filename=$1
    original_file=$2
    target=$3

    echo "[ $filename ]"

    _unlink_target $target

    echo "Linking $original_file to $target"
    ln -s $original_file $target
    echo ""
}

for original_file in $(pwd)/common/git/* ; do
    filename=$(basename $original_file)
    target=/$HOMEDIR/$(whoami)/$filename

    _link_dotfiles $filename $original_file $target
done

for original_file in $(pwd)/common/js/* ; do
    filename=$(basename $original_file)
    target=/$HOMEDIR/$(whoami)/$filename

    _link_dotfiles $filename $original_file $target
done

for original_file in $(pwd)/unix/zsh/* ; do
    filename=$(basename $original_file)
    target=/$HOMEDIR/$(whoami)/$filename

    _link_dotfiles $filename $original_file $target
done


if [[ ! -d /$HOMEDIR/$(whoami)/.config ]] ; then
    echo "Creating ~/.config directory"
    mkdir /$HOMEDIR/$(whoami)/.config
fi


for original_file in $(pwd)/common/nvim ; do
    filename=$(basename $original_file)
    target=/$HOMEDIR/$(whoami)/.config/$filename

    _link_dotfiles $filename $original_file $target
done

for original_file in $(pwd)/common/alacritty ; do
    filename=$(basename $original_file)
    target=/$HOMEDIR/$(whoami)/.config/$filename

    _link_dotfiles $filename $original_file $target
done


if [[ ! -f /$HOMEDIR/$(whoami)/.hushlogin ]] ; then
    echo "Creating ~/.hushlogin"
    touch /$HOMEDIR/$(whoami)/.hushlogin
fi

echo Done!
