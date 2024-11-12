HISTFILE=~/.zsh_history
HISTSIZE=1000000
SAVEHIST=1000000

export EDITOR="nvim"
export TERMINAL="kitty"
export BROWSER="firefox"

export XDG_CONFIG_HOME=$HOME/.config
export XDG_CACHE_HOME=$HOME/.cache
export XDG_DATA_HOME=$HOME/.local/share

export STARSHIP_CONFIG=$HOME/.config/starship/starship.toml

export PATH="$HOME/.local/bin":$PATH
export PATH="$HOME/.cargo/bin":$PATH

export GPG_TTY=$(tty)

export GTK_IM_MODULE=fcitx
export QT_IM_MODULE=fcitx
export XMODIFIERS=@im=fcitx
