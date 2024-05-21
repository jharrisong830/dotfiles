# changing the prompt 
# should be "johngraham @ Johns-MacBook-Pro <cwd> % "
PROMPT='%F{red}%n%f @ %F{green}%m%f: %F{blue}%1~%f %# '

# opam configuration
# [[ ! -r /Users/johngraham/.opam/opam-init/init.zsh ]] || source /Users/johngraham/.opam/opam-init/init.zsh  > /dev/null 2> /dev/null


if command -v brew &> /dev/null # check if brew exists before setting path
then
    # python config for homebrew
    export PATH="$(brew --prefix)/opt/python@3.11/libexec/bin:$PATH"

    # node config for homebrew
    # export PATH="$(brew --prefix)/opt/node@20/bin:$PATH"

    # use homebrew git instead of macOS git
    export PATH="$(brew --prefix)/opt/git/bin:$PATH"

    # alias for 'brew services'
    alias bs="brew services"
fi


if command -v lsd &> /dev/null # check if lsd exists before setting alias
then
    alias ls="lsd --icon-theme fancy"
fi


if command -v caffeinate &> /dev/null # check if caffeinate exists before setting alias
then
    alias caff="caffeinate -d" # program hangs and prevents the display from sleeping
fi

