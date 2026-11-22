#!/bin/bash
# Cross-platform audio player for claude-sounds
# Usage: play.sh <pattern> [always]
# Example: play.sh "write-*.mp3"
#
# Every sound is a separate player process that connects to the system audio
# daemon. Hooks fire in bursts (parallel tool calls, subagents), and a burst of
# short-lived players can leave macOS coreaudiod spinning at 100%+ CPU until it
# is restarted. So sounds are throttled: at most MAX_VOICES play at once, across
# all sessions, and anything over that is dropped rather than queued.
# "always" skips the throttle; use it for rare events that must not be dropped.

SOUNDS_DIR="${CLAUDE_PLUGIN_ROOT}/sounds"
PATTERN="$1"
MAX_VOICES="${CLAUDE_SOUNDS_MAX_VOICES:-3}"
LOCKS="${TMPDIR:-/tmp}/claude-sounds-$UID"

voice=""
if [ "$2" != "always" ]; then
    [ -d "$LOCKS" ] || mkdir -p "$LOCKS" 2>/dev/null
    i=1
    while [ "$i" -le "$MAX_VOICES" ]; do
        # mkdir is atomic: two hooks racing for a voice cannot both get it
        if mkdir "$LOCKS/voice-$i" 2>/dev/null; then
            voice="$LOCKS/voice-$i"
            break
        fi
        i=$((i + 1))
    done
    if [ -z "$voice" ]; then
        # All voices busy: drop the sound. Free voices whose player was killed
        # before it could release them, so they are not lost for good.
        find "$LOCKS" -mindepth 1 -maxdepth 1 -mmin +1 -exec rmdir {} + 2>/dev/null
        exit 0
    fi
fi

f=$(find "$SOUNDS_DIR" -name "$PATTERN" 2>/dev/null | sort -R | head -1)
if [ -z "$f" ]; then
    [ -n "$voice" ] && rmdir "$voice"
    exit 0
fi

(
    # The voice stays taken until the player process is gone
    [ -n "$voice" ] && trap 'rmdir "$voice" 2>/dev/null' EXIT
    case "$(uname -s)" in
        Darwin)  afplay "$f" ;;
        Linux)   paplay "$f" 2>/dev/null || aplay "$f" 2>/dev/null ;;
        MINGW*|MSYS*|CYGWIN*)  powershell.exe -c "(New-Object Media.SoundPlayer '$f').PlaySync()" ;;
    esac
) >/dev/null 2>&1 &
