HISTFILE=${XDG_STATE_HOME:-$HOME/.local/state}/zsh/history
HISTSIZE=1000000
SAVEHIST=1000000
[[ -d ${HISTFILE:h} ]] || mkdir -p ${HISTFILE:h}

setopt auto_cd glob_dots menu_complete extended_glob interactive_comments no_beep
setopt share_history extended_history hist_ignore_all_dups hist_save_no_dups hist_find_no_dups
setopt hist_ignore_space hist_reduce_blanks hist_verify
