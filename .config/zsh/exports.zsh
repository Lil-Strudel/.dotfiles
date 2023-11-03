#!/bin/sh
HISTSIZE=1000000
SAVEHIST=1000000
export EDITOR="nvim"
export TERMINAL="kitty"
export BROWSER="firefox"

export STARSHIP_CONFIG=$HOME/.config/starship/starship.toml

export PATH="$HOME/.local/bin":$PATH
export PATH="$HOME/.cargo/bin":$PATH
