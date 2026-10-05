PLUG_HOME=${XDG_DATA_HOME:-$HOME/.local/share}/zsh/plugins
typeset -gaU _plugs

_plug_compile() {
  local f
  for f in $1/**/*.zsh(N); [[ $f == */test* ]] || zcompile -U $f
}

plug() {
  if [[ $1 == /* ]]; then
    [[ -r $1 ]] && source $1
    return
  fi

  local repo=${1%@*} ref=${1#*@}
  local dir=$PLUG_HOME/${repo:t}
  [[ $ref == $1 ]] && ref=
  _plugs+=($1)

  if [[ ! -d $dir ]]; then
    git -c advice.detachedHead=false clone -q --depth 1 ${ref:+--branch} $ref https://github.com/$repo $dir || return
    _plug_compile $dir
  fi
  local files=($dir/*.plugin.zsh(N) $dir/*.zsh(N))
  source $files[1]
}

plug-update() {
  local p dir ref
  for p in $_plugs; do
    dir=$PLUG_HOME/${${p%@*}:t}
    ref=${p#*@}
    [[ $ref == $p ]] && ref=HEAD
    git -C $dir fetch -q --depth 1 origin $ref && git -C $dir checkout -q FETCH_HEAD && _plug_compile $dir
    print "$p -> $(git -C $dir log -1 --format='%h %cs')"
  done
}
