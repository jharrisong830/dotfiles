autoload -Uz vcs_info
precmd() { vcs_info }

autoload -Uz compinit && compinit

zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}' # case-insensitive completion
zstyle ':vcs_info:*' enable git
zstyle ':vcs_info:git:*' formats $'%F{magenta}\Uf418 %b%f '

setopt prompt_subst

PROMPT='%F{red}%n%f @ %F{green}%m%f: %F{blue}%1~%f ${vcs_info_msg_0_}%# '

if command -v brew &> /dev/null ; then # check if brew exists before setting path
    alias brew-fresh="brew update && brew upgrade && brew autoremove && brew cleanup"
fi


if command -v lsd &> /dev/null ; then # check if lsd exists before setting alias
    alias ls="lsd --icon-theme fancy"
fi


if command -v caffeinate &> /dev/null ; then # check if caffeinate exists before setting alias
    alias caff="caffeinate -d" # program hangs and prevents the display from sleeping
fi

if command -v bat &> /dev/null ; then
    alias cat="bat --theme ansi -pP"
fi

if command -v git &> /dev/null ; then
    alias gs="git status"
    alias gl="git log"
    alias gln="git log -n"
    alias gd="git diff"
    alias gc="git commit"
    alias gcm="git commit -m"
    alias gca="git commit -a"
    alias gcam="git commit -am"
    alias ga="git add"
    alias gb="git branch"
    alias gp="git push"
    alias gpl="git pull"
    alias gsw="git switch"
    alias gch="git checkout"
    alias gr="git restore"
    alias grm="git rm"

    alias reporoot="git rev-parse --show-toplevel"

    if command -v gh &> /dev/null ; then
        alias clone="gh repo clone"
    else
        _clone() {
            if [ -z "$1" ] ; then
                echo "Usage: clone <repository-name>"
                return 1
            fi
            git clone "https://github.com/jharrisong830/$1.git"
        }
        alias clone=_clone
    fi
fi

# setting common aliases
alias ll="ls -lh"
alias la="ls -a"
alias lla="ls -lha"
alias lal="ls -lha"

# zsh plugins (assuming home directory, and plugins are located in .zsh/)
if [[ -d .zsh/plugins/zsh-syntax-highlighting ]] ; then
    source .zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
fi
