# Directory completion for cdm (cd + mkdir -p)
[[ -z ${functions[compdef]} ]] && autoload -Uz compinit && compinit -i
compdef '_files -/' cdm
