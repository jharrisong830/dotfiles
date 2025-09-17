#!/usr/bin/env zsh

setopt globdots # include dotfiles in globbing

REPO_ROOT=$(git rev-parse --show-toplevel)

source $REPO_ROOT/bin/util.sh

for original_file in $REPO_ROOT/common/git/* ; do
    filename=$(basename $original_file)
    target=/$HOMEDIR/$(whoami)/$filename

    _link_dotfiles $filename $original_file $target
done

for original_file in $REPO_ROOT/common/js/* ; do
    filename=$(basename $original_file)
    target=/$HOMEDIR/$(whoami)/$filename

    _link_dotfiles $filename $original_file $target
done

for original_file in $REPO_ROOT/unix/zsh/* ; do
    if [[ $(basename $original_file) != "plugins" ]] ; then # do not link plugins dir
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

for original_plugin in $REPO_ROOT/unix/zsh/plugins/*/ ; do
    pluginname=$(basename $original_plugin)
    target=/$HOMEDIR/$(whoami)/.zsh/$pluginname

    _link_dotfiles $pluginname $original_plugin $target
done




if [[ ! -d /$HOMEDIR/$(whoami)/.config ]] ; then
    echo "Creating ~/.config directory"
    mkdir /$HOMEDIR/$(whoami)/.config
fi


for original_file in $REPO_ROOT/common/nvim ; do
    filename=$(basename $original_file)
    target=/$HOMEDIR/$(whoami)/.config/$filename

    _link_dotfiles $filename $original_file $target
done

for original_file in $REPO_ROOT/common/alacritty ; do
    filename=$(basename $original_file)
    target=/$HOMEDIR/$(whoami)/.config/$filename

    _link_dotfiles $filename $original_file $target
done


if [[ ! -f /$HOMEDIR/$(whoami)/.hushlogin ]] ; then
    echo "Creating ~/.hushlogin"
    touch /$HOMEDIR/$(whoami)/.hushlogin
fi

echo Done!
