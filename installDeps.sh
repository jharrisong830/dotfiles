if [[ $(uname) == "Darwin" ]]; then
    # setup for macOS, homebrew packages and casks

    if ! command -v brew &> /dev/null; then # install homebrew if not already installed
        echo "--- brew NOT FOUND. INSTALLING... ---"
        # /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
    fi
    

    # homebrew formulae
    typeset -a FORMULAE_MACOS=(
        'neovim' 
        'python@3.11' 
        'tree' 
        'erlang' 
        'gh' 
        'git' 
        'lsd' 
    )

    # homebrew taps
    typeset -a TAPS_MACOS=(
        homebrew/services 
        mongodb/brew 
        redis-stack/redis-stack 
    )

    # homebrew casks
    typeset -a CASKS_MACOS=(

    )


    echo "--- UPDATING FORMULAE... ---"
    brew update; brew upgrade

    echo "--- INSTALLING FORMULAE... ---"
    INSTALLED=$(brew list --formulae -1)
    for package in ${FORMULAE_MACOS[@]}; do
        if [[ ${INSTALLED} != *"${package}"* ]]; then # install package if not already installed
            echo "Installing $package"
            brew install $package
        else echo "Already installed -> $package"
        fi
    done
else 
    echo BOOOOOOOOLINUX
fi
