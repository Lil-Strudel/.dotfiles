#!/bin/sh
# Adding dotfiles bare repo for easy convinience
alias dotfiles='/usr/bin/git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME'

alias tf='terraform'
alias tfin='terraform init'
alias tfp='terraform plan'
alias tfa='terraform apply'
alias tff='terraform fmt'
