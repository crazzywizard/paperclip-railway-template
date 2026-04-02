#!/bin/sh
set -e

mkdir -p /paperclip/instances/default/logs
chown -R node:node /paperclip

# Write opencode config for ROOT (agent runs as root inside opencode)
mkdir -p /root/.config/opencode
cat > /root/.config/opencode/opencode.json << EOF
{
  "\$schema": "https://opencode.ai/config.json",
  "permission": {
    "edit": "allow",
    "bash": {
      "*": "allow"
    },
    "webfetch": "allow"
  },
  "providers": {
    "openrouter": {
      "name": "OpenRouter",
      "api_key": "${OPENROUTER_API_KEY}"
    }
  }
}
EOF

exec gosu node "$@"