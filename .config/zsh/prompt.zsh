zmodload zsh/datetime
autoload -Uz add-zsh-hook
setopt transient_rprompt

[[ -n $SSH_CONNECTION ]] && _prompt_host='%F{green}%n@%m%f '

_prompt_git() {
  local -a lines w
  local line head oid ab s
  local -i ahead behind staged unstaged untracked conflicted stash
  lines=(${(f)"$(git status --porcelain=v2 --branch --show-stash 2>/dev/null)"})
  (( $#lines )) || return

  for line in $lines; do
    w=(${=line})
    case $w[1] in
      '#') case $w[2] in
             branch.head) head=$w[3] ;;
             branch.oid) oid=${w[3][1,7]} ;;
             branch.ab) ahead=${w[3]#+} behind=${w[4]#-} ;;
             stash) stash=$w[3] ;;
           esac ;;
      1|2) [[ ${w[2][1]} != . ]] && (( ++staged ))
           [[ ${w[2][2]} != . ]] && (( ++unstaged )) ;;
      u) (( ++conflicted )) ;;
      '?') (( ++untracked )) ;;
    esac
  done

  [[ $head == '(detached)' ]] && head=$oid
  (( conflicted )) && s+="=$conflicted"
  (( stash )) && s+="\$$stash"
  (( unstaged )) && s+="!$unstaged"
  (( staged )) && s+="+$staged"
  (( untracked )) && s+="?$untracked"
  (( ahead )) && s+="⇡$ahead"
  (( behind )) && s+="⇣$behind"

  REPLY=" %B%F{magenta} ${head//\%/%%}%f%b"
  [[ -n $s ]] && REPLY+=" %B%F{red}[$s]%f%b"
}

_prompt_version() {
  local tool=$1 bin m; shift
  for m in $@; do
    [[ -e $m ]] && break
    m=
  done
  [[ -n $m && -n $commands[$tool] ]] || return
  bin=${commands[$tool]:A}
  if [[ $bin == */installs/$tool/* ]]; then
    REPLY=${${bin#*/installs/$tool/}%%/*}
  elif [[ -r ${bin:h:h}/VERSION ]]; then
    REPLY=${${(f)"$(<${bin:h:h}/VERSION)"}[1]#go}
  fi
}

_prompt_preexec() { _prompt_start=$EPOCHREALTIME }

_prompt_precmd() {
  local right git REPLY
  local -i s

  if [[ -n $_prompt_start ]]; then
    s=$(( EPOCHREALTIME - _prompt_start ))
    unset _prompt_start
    if (( s >= 2 )); then
      right+='%F{yellow}'
      (( s >= 3600 )) && right+="$(( s / 3600 ))h"
      (( s >= 60 )) && right+="$(( s % 3600 / 60 ))m"
      right+="$(( s % 60 ))s%f "
    fi
  fi

  right+='%(?..%F{red}✘%?%f )%(1j.%F{blue}✦%j%f .)'

  REPLY=; _prompt_version node package.json .nvmrc .node-version
  [[ -n $REPLY ]] && right+="%F{green} $REPLY%f "
  REPLY=; _prompt_version go go.mod go.work
  [[ -n $REPLY ]] && right+="%F{cyan} $REPLY%f "
  [[ -n $AWS_PROFILE ]] && right+="%F{yellow} $AWS_PROFILE${AWS_REGION:+($AWS_REGION)}%f "

  REPLY=; _prompt_git; git=$REPLY

  PROMPT="${_prompt_host}%B%F{cyan}%(4~|…/%3~|%~)%f%b${git} %(?.%F{green}.%F{red})❯%f "
  RPROMPT=${right% }
}

add-zsh-hook preexec _prompt_preexec
add-zsh-hook precmd _prompt_precmd
