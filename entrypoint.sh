#!/usr/bin/env bash
# Run WeeChat inside a detached tmux session.
# Starts as root to fix bind-mount permissions, then drops to the weechat user.
#
# Usage:
#   docker compose up -d                                             # start in background
#   docker exec -it -u weechat weechat tmux attach -t weechat        # connect
#   Ctrl-b d                                                         # detach

# Fix ownership of bind-mounted directories (they may be created as root)
chown -R weechat:weechat /home/weechat/.config/weechat \
                         /home/weechat/.local/share/weechat \
                         /home/weechat/.cache/weechat

# Ensure UTF-8 locale is set
export LANG=en_US.UTF-8
export LC_ALL=en_US.UTF-8

# Start WeeChat inside a detached tmux session
gosu weechat tmux new-session -d -s weechat \
    -e LANG=en_US.UTF-8 \
    -e LC_ALL=en_US.UTF-8 \
    -e TERM=tmux-256color \
    weechat "$@"

# Keep the container alive as long as the tmux session exists
while gosu weechat tmux has-session -t weechat 2>/dev/null; do
    sleep 5
done
