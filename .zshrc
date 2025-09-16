autoload -Uz vcs_info
precmd() { vcs_info }

autoload -Uz compinit && compinit

zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}' # case-insensitive completion
zstyle ':vcs_info:*' enable git
zstyle ':vcs_info:git:*' formats $'%F{magenta}\Uf418 %b%f '

setopt prompt_subst

PROMPT='%F{red}%n%f @ %F{green}%m%f: %F{blue}%1~%f ${vcs_info_msg_0_}%# '

if command -v brew &> /dev/null ; then # check if brew exists before setting path
    # python config for homebrew
    export PATH="$(brew --prefix)/opt/python/libexec/bin:$PATH"

    # use homebrew git instead of macOS git
    export PATH="$(brew --prefix)/opt/git/bin:$PATH"

    # alias for 'brew services <start | stop> <service>'
    alias mongo-start="brew services start mongodb-community"
    alias mongo-stop="brew services stop mongodb-community"

    alias ollama-start="brew services start ollama"
    alias ollama-stop="brew services stop ollama"

    alias brew-fresh="brew update && brew upgrade && brew autoremove && brew cleanup"
fi


if command -v lsd &> /dev/null ; then # check if lsd exists before setting alias
    alias ls="lsd --icon-theme fancy"
fi


if command -v caffeinate &> /dev/null ; then # check if caffeinate exists before setting alias
    alias caff="caffeinate -d" # program hangs and prevents the display from sleeping
fi

if command -v git &> /dev/null ; then
    alias gs="git status"
    alias gl="git log"
    alias gc="git commit"
    alias gcm="git commit -m"
    alias gca="git commit -a"
    alias gcam="git commit -am"
    alias ga="git add"
    alias gb="git branch"
    alias gp="git push"
    alias gsw="git switch"
    alias gch="git checkout"
    alias gr="git restore"
fi

# setting common aliases
alias ll="ls -lh"
alias la="ls -a"
alias lla="ls -lha"
alias lal="ls -lha"
