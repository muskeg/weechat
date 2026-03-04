#!/usr/bin/env bash
# Run WeeChat as the container's main process.
#
# Usage:
#   docker run -it --name weechat weechat     # start WeeChat
#   Ctrl-p Ctrl-q                              # detach (container keeps running)
#   docker attach weechat                      # reattach

exec weechat "$@"
