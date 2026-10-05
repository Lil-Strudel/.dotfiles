zmodload zsh/complist
autoload -Uz compinit

zstyle ':completion:*' menu select
zstyle ':completion:*' matcher-list '' 'm:{a-zA-Z}={A-Za-z}' 'r:|=*' 'l:|=* r:|=*'
zstyle ':completion:*' list-colors ''
_comp_options+=(globdots)

() {
  local dump=${XDG_CACHE_HOME:-$HOME/.cache}/zsh/zcompdump
  [[ -d ${dump:h} ]] || mkdir -p ${dump:h}
  [[ -n $dump(#qN.mh+24) ]] && rm -f $dump
  compinit -C -d $dump
  [[ $dump.zwc -nt $dump ]] || zcompile $dump
}

bindkey -M menuselect '^h' vi-backward-char
bindkey -M menuselect '^j' vi-down-line-or-history
bindkey -M menuselect '^k' vi-up-line-or-history
bindkey -M menuselect '^l' vi-forward-char
bindkey -M menuselect '^[[Z' reverse-menu-complete
