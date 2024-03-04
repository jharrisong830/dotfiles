# changing the prompt 
# should be "johngraham @ Johns-MacBook-Pro <cwd> % "
PROMPT='%F{red}%n%f @ %F{green}%m%f: %F{blue}%1~%f %# '

alias ls="lsd --icon-theme fancy"

# opam configuration
[[ ! -r /Users/johngraham/.opam/opam-init/init.zsh ]] || source /Users/johngraham/.opam/opam-init/init.zsh  > /dev/null 2> /dev/null

# python config for homebrew
export PATH="$(brew --prefix)/opt/python@3.11/libexec/bin:$PATH"

# node config for homebrew
export PATH="$(brew --prefix)/opt/node@20/bin:$PATH"

# use homebrew git instead of macOS git
export PATH="$(brew --prefix)/opt/git/bin:$PATH"
