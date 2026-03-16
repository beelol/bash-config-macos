# Git alias tab completion for zsh (branches, remotes, refs, etc.)
#
# Why it's done this way:
# - Zsh doesn't complete aliases by expanding them. Typing "gc <Tab>" runs completion
#   for the command "gc", not "git checkout", so you get no branch names.
# - The built-in _git completion is a dispatcher: it looks at the first argument
#   (checkout, push, pull, ...) and runs the right sub-completion. So we have to
#   make it see "git checkout ..." when you're actually typing "gc ...".
# - The wrapper functions rewrite the completion "words" array and increment
#   CURRENT so _git receives (git checkout <your-args>) and thinks you're
#   completing for "git checkout". Same idea for push, pull, merge, etc.
# - Aliases like "pso" = "git push origin" need an extra word in the rewrite
#   so we use a separate one-liner that inserts (git push origin ...).
#
# compdef is provided by zsh's completion system; ensure it's loaded (macOS zsh doesn't run compinit by default)
[[ -z ${functions[compdef]} ]] && autoload -Uz compinit && compinit -i

_git_alias() {
  local subcmd="$1"
  shift
  ((CURRENT++))
  words=(git "$subcmd" "$@")
  _git
}
_gc()  { _git_alias checkout "${words[@]:1}" }
_gps() { _git_alias push "${words[@]:1}" }
_pu()  { _git_alias pull "${words[@]:1}" }
_gm()  { _git_alias merge "${words[@]:1}" }
_gf()  { _git_alias fetch "${words[@]:1}" }
_gb()  { _git_alias branch "${words[@]:1}" }
_rbs() { _git_alias rebase "${words[@]:1}" }
_gr()  { _git_alias reset "${words[@]:1}" }
_pso() { ((CURRENT++)); words=(git push origin "${words[@]:1}"); _git }
_puo() { ((CURRENT++)); words=(git pull origin "${words[@]:1}"); _git }
_drb() { ((CURRENT++)); words=(git push origin --delete "${words[@]:1}"); _git }

compdef _gc gc
compdef _gps gps
compdef _pu pu
compdef _gm gm
compdef _gf gf
compdef _gb gb
compdef _rbs rbs
compdef _gr gr
compdef _pso pso
compdef _puo puo
compdef _drb drb
