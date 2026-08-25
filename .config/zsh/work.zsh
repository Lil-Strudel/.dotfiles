alias openclaude='ANTHROPIC_BASE_URL=http://172.16.66.62:9000/rmx/v0 \
ANTHROPIC_API_KEY="aaron" \
ANTHROPIC_DEFAULT_OPUS_MODEL=large \
ANTHROPIC_DEFAULT_SONNET_MODEL=large \
ANTHROPIC_DEFAULT_HAIKU_MODEL=small \
DISABLE_TELEMETRY=1 \
claude'

alogin() {
    aws sso login --sso-session rxco
}

plug "$HOME/Documents/code/infra-live/completions/pu.plugin.zsh"
plug "$HOME/Documents/code/infra-org/completions/pu.plugin.zsh"
