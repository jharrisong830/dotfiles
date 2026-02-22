# .zprofile
# use to set path and editor

if [[ -d /opt/homebrew ]] ; then
    eval "$(/opt/homebrew/bin/brew shellenv)"

    # add brew python to front of path
    export PATH="$HOMEBREW_PREFIX/opt/python/libexec/bin:$PATH";
    
    # add brew git to front of path
    export PATH="$HOMEBREW_PREFIX/opt/git/bin:$PATH";
fi

if [[ -d $HOME/.zsh/bin ]] ; then
    export PATH="$HOME/.zsh/bin:$PATH"
fi
