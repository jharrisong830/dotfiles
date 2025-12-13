# .zprofile
# use to set path and editor

if [[ -d /opt/homebrew ]] ; then
    export HOMEBREW_PREFIX="/opt/homebrew";
    export HOMEBREW_CELLAR="/opt/homebrew/Cellar";
    export HOMEBREW_REPOSITORY="/opt/homebrew";
    export HOMEBREW_SHELLENV_PREFIX="/opt/homebrew";
    export PATH="/opt/homebrew/bin:/opt/homebrew/sbin${PATH+:$PATH}";
    export MANPATH="/opt/homebrew/share/man${MANPATH+:$MANPATH}:";
    export INFOPATH="/opt/homebrew/share/info:${INFOPATH:-}";

    # add brew python to front of path
    export PATH="$HOMEBREW_PREFIX/opt/python/libexec/bin:$PATH";
    
    # add brew git to front of path
    export PATH="$HOMEBREW_PREFIX/opt/git/bin:$PATH";
fi

if [[ -d $HOME/.local/share/swiftly ]]; then
    . "/home/johng/.local/share/swiftly/env.sh"
fi

