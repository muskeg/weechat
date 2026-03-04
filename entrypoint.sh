#!/usr/bin/env bash
# Run WeeChat as the container's main process.
# Starts as root to fix bind-mount permissions, then drops to the weechat user.
#
# Usage:
#   docker compose up -d                       # start in background
#   docker attach weechat                      # connect to WeeChat
#   Ctrl-p Ctrl-q                              # detach (container keeps running)

# Fix ownership of bind-mounted directories (they may be created as root)
chown -R weechat:weechat /home/weechat/.config/weechat \
                         /home/weechat/.local/share/weechat \
                         /home/weechat/.cache/weechat

# Drop to weechat user and run WeeChat
exec gosu weechat weechat "$@"
