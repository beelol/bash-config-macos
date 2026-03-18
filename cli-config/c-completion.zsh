# File/directory completion for c alias (Cursor)
[[ -z ${functions[compdef]} ]] && autoload -Uz compinit && compinit -i
compdef _files c
