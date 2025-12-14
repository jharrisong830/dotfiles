#!/usr/bin/env zsh

setopt globdots # include dotfiles in globbing

REPO_ROOT=$(git rev-parse --show-toplevel)

source $REPO_ROOT/bin/util.sh

for original_file in $REPO_ROOT/common/git/* ; do
    filename=$(basename $original_file)
    target=$HOME/$filename

    _link_dotfiles $filename $original_file $target
done

for original_file in $REPO_ROOT/common/js/* ; do
    filename=$(basename $original_file)
    target=$HOME/$filename

    _link_dotfiles $filename $original_file $target
done

for original_file in $REPO_ROOT/unix/zsh/* ; do
    if [[ $(basename $original_file) != "plugins" ]] ; then # do not link plugins dir
        filename=$(basename $original_file)
        target=$HOME/$filename

        _link_dotfiles $filename $original_file $target
    fi
done




# zsh plugins

if [[ ! -d $HOME/.zsh ]] ; then
    echo "Creating ~/.zsh directory"
    mkdir $HOME/.zsh
fi

git submodule init
git submodule update # gets most recent version of submodule repos

for original_plugin in $REPO_ROOT/unix/zsh/plugins/*/ ; do
    pluginname=$(basename $original_plugin)
    target=$HOME/.zsh/$pluginname

    _link_dotfiles $pluginname $original_plugin $target
done




if [[ ! -d $HOME/.config ]] ; then
    echo "Creating ~/.config directory"
    mkdir $HOME/.config
fi


for original_file in $REPO_ROOT/common/nvim ; do
    filename=$(basename $original_file)
    target=$HOME/.config/$filename

    _link_dotfiles $filename $original_file $target
done

for original_file in $REPO_ROOT/common/alacritty ; do
    filename=$(basename $original_file)
    target=$HOME/.config/$filename

    _link_dotfiles $filename $original_file $target
done

for original_file in $REPO_ROOT/common/btop ; do
    filename=$(basename $original_file)
    target=$HOME/.config/$filename

    _link_dotfiles $filename $original_file $target
done


if [[ ! -f $HOME/.hushlogin ]] ; then
    echo "Creating ~/.hushlogin"
    touch $HOME/.hushlogin
fi

echo Done!
