alias tf='terraform'
alias tfin='terraform init'
alias tfp='terraform plan'
alias tfa='terraform apply'
alias tff='terraform fmt'

alias gfgp='git fetch && git pull'

alias c='clear'

alias gs="git switch"
alias gsc="git switch -c"

[[ -z "$CLAUDECODE" ]] && alias cd='z'

alias ssh='TERM=xterm-256color ssh'

if [[ "$(hostname)" == "strudel-rx" ]]; then
    alias openclaude='ANTHROPIC_BASE_URL=http://172.16.66.62:9000/rmx/v0 \
ANTHROPIC_API_KEY="aaron" \
ANTHROPIC_DEFAULT_OPUS_MODEL=large \
ANTHROPIC_DEFAULT_SONNET_MODEL=large \
ANTHROPIC_DEFAULT_HAIKU_MODEL=small \
DISABLE_TELEMETRY=1 \
claude'

    alogin() {
        local profiles=$(grep -B 1 "sso_session =" ~/.aws/config | grep "\[profile" | sed -e 's/\[profile \(.*\)\]/\1/')

        if [[ -z "$profiles" ]]; then
            echo "No SSO profiles found in ~/.aws/config"
            return 1
        fi

        local profile_list=(${(f)profiles})

        local first=$profile_list[1]
        echo "Keying into profile: $first..."
        if ! aws sso login --profile "$first"; then
            echo "Login failed for $first, aborting"
            return 1
        fi

        local pids=()
        for profile in $profile_list[2,-1]; do
            echo "Keying into profile: $profile..."
            aws sso login --profile "$profile" &
            pids+=($!)
        done

        for pid in $pids; do
            wait "$pid"
        done
    }
fi
