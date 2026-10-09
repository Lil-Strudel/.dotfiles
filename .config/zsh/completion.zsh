zmodload zsh/complist
autoload -Uz compinit

zstyle ':completion:*' menu select
zstyle ':completion:*' matcher-list '' 'm:{a-zA-Z}={A-Za-z}' 'r:|=*' 'l:|=* r:|=*'
zstyle ':completion:*' list-colors ''
_comp_options+=(globdots)

() {
  local dump=${XDG_CACHE_HOME:-$HOME/.cache}/zsh/zcompdump dir
  [[ -d ${dump:h} ]] || mkdir -p ${dump:h}
  [[ -n $dump(#qN.mh+24) ]] && rm -f $dump
  for dir in /usr/share/zsh/{site-functions,vendor-completions}; do
    [[ $dir -nt $dump ]] && rm -f $dump
  done
  compinit -C -d $dump
  [[ $dump.zwc -nt $dump ]] || zcompile $dump
}

_workmux() {
  unfunction _workmux
  source <(workmux completions zsh)
  _workmux "$@"
}
compdef _workmux workmux

bindkey -M menuselect '^h' vi-backward-char
bindkey -M menuselect '^j' vi-down-line-or-history
bindkey -M menuselect '^k' vi-up-line-or-history
bindkey -M menuselect '^l' vi-forward-char
bindkey -M menuselect '^[[Z' reverse-menu-complete
