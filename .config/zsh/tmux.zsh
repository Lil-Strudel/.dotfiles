if [ -x "$(command -v tmux)" ] && [ -n "${DISPLAY}" ] && [ -z "${TMUX}" ] && [ "$TERM_PROGRAM" != "vscode" ]; then
    tmux
fi
