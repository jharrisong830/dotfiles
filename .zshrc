# changing the prompt 
# should be "johngraham @ Johns-MacBook-Pro <cwd> % "
autoload -Uz vcs_info
precmd() { vcs_info }

autoload -Uz compinit && compinit

zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}' # case-insensitive completion
zstyle ':vcs_info:*' enable git
zstyle ':vcs_info:git:*' formats $'%F{magenta}\Uf418 %b%f '

setopt prompt_subst

PROMPT='%F{red}%n%f @ %F{green}%m%f: %F{blue}%1~%f ${vcs_info_msg_0_}%# '

# opam configuration
[[ ! -r /Users/johngraham/.opam/opam-init/init.zsh ]] || source /Users/johngraham/.opam/opam-init/init.zsh  > /dev/null 2> /dev/null

# function _killRedisJob() {
#     kill -TERM $(jobs | sed -En 's/^\[([0-9]+)\].*redis-stack-server &> \/dev\/null$/%\1/p')
# }

if command -v brew &> /dev/null # check if brew exists before setting path
then
    # python config for homebrew
    export PATH="$(brew --prefix)/opt/python/libexec/bin:$PATH"

    # node config for homebrew
    # export PATH="$(brew --prefix)/opt/node@20/bin:$PATH" # use LTS first

    # use homebrew git instead of macOS git
    export PATH="$(brew --prefix)/opt/git/bin:$PATH"

    # alias for 'brew services <start | stop> <service>'
    alias mongo-start="brew services start mongodb-community"
    alias mongo-stop="brew services stop mongodb-community"
    
    alias ollama-start="brew services start ollama"
    alias ollama-stop="brew services stop ollama"

    alias brew-fresh="brew update && brew upgrade && brew autoremove && brew cleanup"

    # use homebrew ruby instead of macOS ruby
    # export PATH="$(brew --prefix)/opt/ruby/bin:$PATH"
    # export PATH="$(brew --prefix)/lib/ruby/gems/3.3.0/bin:$PATH" # gems binaries
fi


if command -v lsd &> /dev/null # check if lsd exists before setting alias
then
    alias ls="lsd --icon-theme fancy"
fi


if command -v caffeinate &> /dev/null # check if caffeinate exists before setting alias
then
    alias caff="caffeinate -d" # program hangs and prevents the display from sleeping
fi


# if command -v redis-stack-server &> /dev/null
# then
#     alias redis-start="redis-stack-server &> /dev/null &" # start redis server in the background
#     alias redis-stop="_killRedisJob" # get the job number of redis, terminate that job
# fi

