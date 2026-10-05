#!/usr/bin/env zsh
zmodload zsh/datetime

IFS='|' read -r model effort tin tout h5 h5r d7 d7r < <(jq -r '[
  .model.display_name,
  .effort.level // "",
  .context_window.total_input_tokens // 0,
  .context_window.total_output_tokens // 0,
  (.rate_limits.five_hour.used_percentage | if . then floor else "" end),
  .rate_limits.five_hour.resets_at // "",
  (.rate_limits.seven_day.used_percentage | if . then floor else "" end),
  .rate_limits.seven_day.resets_at // ""
] | map(tostring) | join("|")')

for name hex in blue 8ba4b0 violet a292a3 aqua 8ea4a2 green 87a987 ok 8a9a7b orange b6927b teal 949fb5 gray a6a69c dim 625e5a yellow c4b28a red c4746e; do
  typeset $name=$'\e[38;2;'$((16#${hex[1,2]}))';'$((16#${hex[3,4]}))';'$((16#${hex[5,6]}))'m'
done
rst=$'\e[0m'
sep="  $dim│  "
clock=$'\uf017' cal=$'\uf073'

tok() {
  if (( $1 >= 1000000 )); then printf '%.1fm' $(( $1 / 1000000.0 ))
  elif (( $1 >= 1000 )); then printf '%.1fk' $(( $1 / 1000.0 ))
  else printf '%d' $1
  fi
}

pct() {
  local c=$ok
  (( $1 >= 60 )) && c=$yellow
  (( $1 >= 85 )) && c=$red
  print -rn -- "$c$1%"
}

until_reset() {
  local s=$(( $1 - EPOCHSECONDS ))
  (( s < 0 )) && s=0
  (( s >= 3600 )) && print -rn -- "$(( s / 3600 ))h"
  print -rn -- "$(( s % 3600 / 60 ))m"
}

out="$blue$model${effort:+ $violet$effort}"
out+="$sep$aqua↑$(tok $tin) $green↓$(tok $tout)"
[[ -n $h5 ]] && out+="$sep$orange$clock $(pct $h5) $gray$(until_reset $h5r)"
[[ -n $d7 ]] && out+="$sep$teal$cal $(pct $d7) $gray$(strftime %a $d7r)"
print -rn -- "$out$rst"
