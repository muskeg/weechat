#!/usr/bin/env bash
# Run WeeChat inside a screen session.
# Starts as root to fix bind-mount permissions, then drops to the weechat user.
#
# Usage:
#   docker compose up -d                                    # start in background
#   docker exec -it weechat screen -r weechat               # connect to WeeChat
#   Ctrl-a d                                                # detach from screen

# Fix ownership of bind-mounted directories (they may be created as root)
chown -R weechat:weechat /home/weechat/.config/weechat \
                         /home/weechat/.local/share/weechat \
                         /home/weechat/.cache/weechat

# Start WeeChat inside a screen session and keep the container alive
exec gosu weechat screen -S weechat weechat "$@"
