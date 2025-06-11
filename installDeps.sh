#!/usr/bin/env zsh

if [[ $(uname) == "Darwin" ]]; then
    # setup for macOS, homebrew packages and casks

    if ! command -v brew &> /dev/null; then # install homebrew if not already installed
        echo "--- brew NOT FOUND. INSTALLING... ---"
        /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
    fi
    

    # homebrew formulae
    typeset -a FORMULAE_MACOS=(
        'neovim' 
        'python' 
        'gh' 
        'git' 
        'lsd'
    )

    # homebrew casks
    typeset -a CASKS_MACOS=(
        discord
        firefox
        font-monaspace
        font-monaspace-nerd-font
        iterm2
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

    echo "--- INSTALLING CASKS... ---"
    INSTALLED=$(brew list --cask -1)
    for package in ${CASKS_MACOS[@]}; do
        if [[ ${INSTALLED} != *"${package}"* ]]; then # install package if not already installed
            echo "Installing $package"
            brew install --cask $package
        else echo "Already installed -> $package"
        fi
    done
else 
    echo BOOOOOOOOLINUX
fi
