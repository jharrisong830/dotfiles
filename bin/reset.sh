#!/usr/bin/env zsh

setopt globdots # include dotfiles in globbing

REPO_ROOT=$(git rev-parse --show-toplevel)

source $REPO_ROOT/bin/util.sh

for original_file in $REPO_ROOT/common/git/* ; do
    filename=$(basename $original_file)
    target=$HOME/$filename

    _unlink_target $target
done

for original_file in $REPO_ROOT/common/js/* ; do
    filename=$(basename $original_file)
    target=$HOME/$filename

    _unlink_target $target
done

for original_file in $REPO_ROOT/unix/zsh/* ; do
    if [[ $(basename $original_file) != "plugins" ]] ; then # do not link plugins dir
        filename=$(basename $original_file)
        target=$HOME/$filename

        _unlink_target $target
    fi
done




# zsh plugins

if [[ -d $HOME/.zsh ]] ; then
    echo "Deleting directory ~/.zsh"
    rm -rf $HOME/.zsh
fi





for original_file in $REPO_ROOT/common/nvim ; do
    filename=$(basename $original_file)
    target=$HOME/.config/$filename

    _unlink_target $target
done

for original_file in $REPO_ROOT/common/alacritty ; do
    filename=$(basename $original_file)
    target=$HOME/.config/$filename

    _unlink_target $target
done

for original_file in $REPO_ROOT/common/btop ; do
    filename=$(basename $original_file)
    target=$HOME/.config/$filename

    _unlink_target $target
done


echo Done!
