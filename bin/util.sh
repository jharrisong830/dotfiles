HOMEDIR="Users"

if [[ $(uname) != "Darwin" ]] ; then
    HOMEDIR="home"
fi

REPO_ROOT=$(git rev-parse --show-toplevel)

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
