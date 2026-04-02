#!/bin/sh
set -e

# When Railway mounts a volume at /paperclip it is often not writable by the node user.
# Create dirs Paperclip needs and ensure the whole tree is owned by node.
mkdir -p /paperclip/instances/default/logs
chown -R node:node /paperclip

# Write opencode config so OpenRouter models are discovered
mkdir -p /home/node/.config/opencode
cat > /home/node/.config/opencode/config.json << EOF
{
  "providers": {
    "openrouter": {
      "name": "OpenRouter",
      "api_key": "${OPENROUTER_API_KEY}"
    }
  },
  "autoapprove": [
    "read",
    "write",
    "edit",
    "bash",
    "web_fetch",
    "list"
  ]
}
EOF
chown -R node:node /home/node/.config

exec gosu node "$@"