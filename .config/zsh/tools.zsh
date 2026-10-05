eval "$(mise activate zsh)"
add-zsh-hook -d precmd _mise_hook_precmd
unset -f command_not_found_handler
source <(fzf --zsh)
[[ -z $CLAUDECODE ]] && eval "$(zoxide init zsh --cmd cd)"
