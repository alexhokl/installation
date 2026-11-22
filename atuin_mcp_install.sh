#!/bin/bash

if [[ -z "$(which atuin)" ]]; then
  echo "atuin is not installed; skipping atuin MCP installation."
  exit 0
fi

atuin mcp install claude
atuin mcp install opencode
