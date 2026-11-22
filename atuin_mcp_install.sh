#!/bin/bash

if [[ -z "$(which atuin)" ]]; then
  echo "atuin is not installed; skipping atuin MCP installation."
  exit 0
fi

atuin setup --only --mcp --agents claude-code
atuin setup --only --mcp --agents opencode
