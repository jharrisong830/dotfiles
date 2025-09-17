#!/usr/bin/env zsh

setopt globdots # include dotfiles in globbing

HOMEDIR="Users"

if [[ $(uname) != "Darwin" ]] ; then
    HOMEDIR="home"
fi

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
    if [[ $(basename original_file) == "plugins" ]] ; then # do not link plugins dir
        filename=$(basename $original_file)
        target=/$HOMEDIR/$(whoami)/$filename

        _link_dotfiles $filename $original_file $target
    fi
done




# zsh plugins

if [[ ! -d /$HOMEDIR/$(whoami)/.zsh ]] ; then
    echo "Creating ~/.zsh directory"
    mkdir /$HOMEDIR/$(whoami)/.zsh
fi

git submodule update # gets most recent version of submodule repos

for original_plugin in $(pwd)/unix/zsh/plugins/*/ ; do
    pluginname=$(basename $original_plugin)
    target=/$HOMEDIR/$(whoami)/.zsh/$pluginname

    _link_dotfiles $pluginname $original_plugin $target
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
