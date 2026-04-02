#!/bin/sh
set -e

mkdir -p /paperclip/instances/default/logs
chown -R node:node /paperclip

# Write opencode config with full permissions and OpenRouter
mkdir -p /home/node/.config/opencode
cat > /home/node/.config/opencode/opencode.json << EOF
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
chown -R node:node /home/node/.config

exec gosu node "$@"