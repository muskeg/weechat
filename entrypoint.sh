#!/usr/bin/env bash
# Start (or reattach to) a screen session running WeeChat.
#
# Usage inside the container:
#   docker run -it weechat          # creates a new screen+weechat session
#   docker exec -it <cid> bash      # then: screen -r weechat

SESSION_NAME="weechat"

# If a screen session already exists, reattach to it
if screen -list | grep -q "\.${SESSION_NAME}[[:space:]]"; then
    exec screen -r "$SESSION_NAME"
fi

# Otherwise start a new detached session, then attach
screen -dmS "$SESSION_NAME" weechat "$@"
exec screen -r "$SESSION_NAME"
