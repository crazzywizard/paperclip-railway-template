#!/bin/sh
set -e

mkdir -p /paperclip/instances/default/logs
chown -R node:node /paperclip

mkdir -p /root/.config/opencode
cat > /root/.config/opencode/opencode.json << EOF
{
  "\$schema": "https://opencode.ai/config.json",
  "permission": {
    "edit": "allow",
    "bash": {
      "*": "allow"
    },
    "webfetch": "allow",
    "read": "allow",
    "write": "allow",
    "external_directory": {
      "*": "allow"
    }
  },
  "providers": {
    "fireworks": {
      "name": "Fireworks AI",
      "api_key": "${FIREWORKS_API_KEY}"
    }
  }
}
EOF

exec gosu node "$@"