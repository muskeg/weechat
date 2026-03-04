#!/usr/bin/env bash
# Run WeeChat inside a detached screen session.
# Starts as root to fix bind-mount permissions, then drops to the weechat user.
#
# Usage:
#   docker compose up -d                                           # start in background
#   docker exec -it -u weechat weechat screen -xAU weechat         # connect
#   Ctrl-a d                                                       # detach

# Fix ownership of bind-mounted directories (they may be created as root)
chown -R weechat:weechat /home/weechat/.config/weechat \
                         /home/weechat/.local/share/weechat \
                         /home/weechat/.cache/weechat

# Start WeeChat inside a detached screen session with UTF-8 support
gosu weechat screen -dmSU weechat weechat "$@"

# Keep the container alive as long as the screen session exists
while gosu weechat screen -list | grep -q '\.weechat\b'; do
    sleep 5
done
