#!/bin/bash
# Hello Greeting Hook
# Invokes /hello command on session start (if enabled)
#
# To enable: Add to settings.json hooks.SessionStart
# To disable: Remove from hooks or set GREETING_DISABLED=1

if [ "${GREETING_DISABLED:-0}" = "1" ]; then
    exit 0
fi

# The /hello command will be invoked by Claude Code
# This hook just signals that greeting should happen
echo "greeting:enabled"
