bindkey -v
KEYTIMEOUT=1

_vi_cursor() { [[ $KEYMAP == vicmd ]] && print -n '\e[2 q' || print -n '\e[6 q' }
zle -N _vi_cursor
autoload -Uz add-zle-hook-widget
add-zle-hook-widget keymap-select _vi_cursor
add-zle-hook-widget line-init _vi_cursor

autoload -Uz up-line-or-beginning-search down-line-or-beginning-search edit-command-line select-bracketed select-quoted
zle -N up-line-or-beginning-search
zle -N down-line-or-beginning-search
zle -N edit-command-line
zle -N select-bracketed
zle -N select-quoted

bindkey -M viins '^?' backward-delete-char
bindkey -M viins '^W' backward-kill-word
bindkey -M viins '^A' beginning-of-line
bindkey -M viins '^E' end-of-line
bindkey -M viins '^[[A' up-line-or-beginning-search
bindkey -M viins '^[OA' up-line-or-beginning-search
bindkey -M viins '^[[B' down-line-or-beginning-search
bindkey -M viins '^[OB' down-line-or-beginning-search
bindkey -M vicmd k up-line-or-beginning-search
bindkey -M vicmd j down-line-or-beginning-search
bindkey -M vicmd v edit-command-line

_tmux_nav() {
  local -A dir=($'\C-h' L $'\C-j' D $'\C-k' U $'\C-l' R)
  [[ -n $TMUX ]] && tmux select-pane -t $TMUX_PANE -$dir[$KEYS]
}
zle -N _tmux_nav
for m in viins vicmd; do
  for c in '^H' '^J' '^K' '^L'; do bindkey -M $m $c _tmux_nav; done
done

for m in visual viopp; do
  for c in {a,i}${(s..)^:-'()[]{}<>bB'}; do bindkey -M $m $c select-bracketed; done
  for c in {a,i}{\',\",\`}; do bindkey -M $m $c select-quoted; done
done
unset m c
