#!/bin/bash
# Cross-platform audio player for claude-sounds
# Usage: play.sh <pattern>
# Example: play.sh "write-*.mp3"

SOUNDS_DIR="${CLAUDE_PLUGIN_ROOT}/sounds"
PATTERN="$1"

f=$(find "$SOUNDS_DIR" -name "$PATTERN" 2>/dev/null | sort -R | head -1)
[ -z "$f" ] && exit 0

case "$(uname -s)" in
    Darwin)  afplay "$f" & ;;
    Linux)   paplay "$f" 2>/dev/null || aplay "$f" 2>/dev/null & ;;
    MINGW*|MSYS*|CYGWIN*)  powershell.exe -c "(New-Object Media.SoundPlayer '$f').PlaySync()" & ;;
esac
