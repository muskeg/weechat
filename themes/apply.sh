#!/bin/bash
# Apply a WeeChat theme by sending commands through the FIFO pipe.
#
# Usage:
#   ./themes/apply.sh gruvbox              # if WeeChat runs on host
#   ./themes/apply.sh gruvbox --docker     # if WeeChat runs in Docker

set -euo pipefail

THEME="${1:?Usage: $0 <theme-name> [--docker]}"
DOCKER_MODE="${2:-}"

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
COMMANDS_FILE="$SCRIPT_DIR/$THEME/commands.txt"

if [[ ! -f "$COMMANDS_FILE" ]]; then
    echo "Error: theme '$THEME' not found at $COMMANDS_FILE"
    exit 1
fi

# Find the FIFO pipe
find_fifo() {
    if [[ "$DOCKER_MODE" == "--docker" ]]; then
        # Inside the Docker container, the runtime dir is typically /run/user/<uid> or /tmp
        local fifo
        fifo=$(docker exec weechat sh -c 'ls /tmp/weechat_fifo_* /run/user/*/weechat_fifo_* 2>/dev/null | head -1')
        if [[ -z "$fifo" ]]; then
            echo "Error: could not find WeeChat FIFO pipe in container" >&2
            exit 1
        fi
        echo "$fifo"
    else
        local fifo
        fifo=$(ls /tmp/weechat_fifo_* /run/user/*/weechat_fifo_* 2>/dev/null | head -1)
        if [[ -z "$fifo" ]]; then
            echo "Error: could not find WeeChat FIFO pipe on host" >&2
            exit 1
        fi
        echo "$fifo"
    fi
}

send_command() {
    local cmd="$1"
    if [[ "$DOCKER_MODE" == "--docker" ]]; then
        docker exec weechat sh -c "echo '* $cmd' > $FIFO_PATH"
    else
        echo "* $cmd" > "$FIFO_PATH"
    fi
}

FIFO_PATH=$(find_fifo)
echo "Using FIFO: $FIFO_PATH"
echo "Applying theme: $THEME"

count=0
while IFS= read -r line; do
    # Skip empty lines and comments
    [[ -z "$line" || "$line" =~ ^[[:space:]]*# ]] && continue
    send_command "$line"
    count=$((count + 1))
done < "$COMMANDS_FILE"

echo "Done — sent $count commands to WeeChat."
