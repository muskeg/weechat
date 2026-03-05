# -*- coding: utf-8 -*-
#
# theme_loader.py — WeeChat script
# Load color themes from commands.txt files on startup or on demand.
#
# Author: raph <the.small.swamp@gmail.com>
# License: MIT
#
# Usage:
#   /theme list            — list available themes
#   /theme apply <name>    — apply a theme (runs all /set commands)
#   /theme current         — show which theme is active
#
# The script looks for themes in THEMES_DIR (default: ~/themes).
# Each theme is a subfolder containing a commands.txt file.
#
# On load, it auto-applies the theme stored in the WeeChat option
# plugins.var.python.theme_loader.active_theme (if set).

import os
import weechat

SCRIPT_NAME = "theme_loader"
SCRIPT_AUTHOR = "raph"
SCRIPT_VERSION = "1.0"
SCRIPT_LICENSE = "MIT"
SCRIPT_DESC = "Load color themes from commands.txt files"

# Where to look for theme folders (inside the container).
# Mapped via docker-compose volume: ./themes:/home/weechat/themes:ro
THEMES_DIR = os.path.expanduser("~/themes")


def get_active_theme():
    """Return the currently configured theme name, or empty string."""
    return weechat.config_get_plugin("active_theme")


def set_active_theme(name):
    """Persist the active theme name so it auto-applies on next load."""
    weechat.config_set_plugin("active_theme", name)


def list_themes():
    """Return a list of available theme names (subdirs with commands.txt)."""
    if not os.path.isdir(THEMES_DIR):
        return []
    return sorted(
        d for d in os.listdir(THEMES_DIR)
        if os.path.isfile(os.path.join(THEMES_DIR, d, "commands.txt"))
    )


def apply_theme(name, silent=False):
    """Parse commands.txt for a theme and execute every /set and /save line."""
    commands_file = os.path.join(THEMES_DIR, name, "commands.txt")
    if not os.path.isfile(commands_file):
        weechat.prnt("", f"{SCRIPT_NAME}: theme '{name}' not found "
                         f"(no {commands_file})")
        return False

    count = 0
    with open(commands_file, "r", encoding="utf-8") as f:
        for line in f:
            line = line.strip()
            # Skip blanks and comments
            if not line or line.startswith("#"):
                continue
            # Only execute /set and /save commands for safety
            if line.startswith("/set ") or line == "/save":
                weechat.command("", line)
                count += 1
            else:
                if not silent:
                    weechat.prnt("", f"{SCRIPT_NAME}: skipped non-set "
                                     f"command: {line}")

    set_active_theme(name)
    if not silent:
        weechat.prnt("", f"{SCRIPT_NAME}: applied theme '{name}' "
                         f"({count} commands)")
    return True


def theme_command_cb(data, buffer, args):
    """Handle /theme <subcommand> [args]."""
    argv = args.strip().split(None, 1)
    subcmd = argv[0].lower() if argv else "help"

    if subcmd == "list":
        themes = list_themes()
        active = get_active_theme()
        if not themes:
            weechat.prnt("", f"{SCRIPT_NAME}: no themes found in "
                             f"{THEMES_DIR}")
        else:
            weechat.prnt("", f"{SCRIPT_NAME}: available themes:")
            for t in themes:
                marker = " (active)" if t == active else ""
                weechat.prnt("", f"  {t}{marker}")

    elif subcmd == "apply":
        if len(argv) < 2:
            weechat.prnt("", f"{SCRIPT_NAME}: usage: /theme apply <name>")
        else:
            apply_theme(argv[1])

    elif subcmd == "current":
        active = get_active_theme()
        if active:
            weechat.prnt("", f"{SCRIPT_NAME}: active theme: {active}")
        else:
            weechat.prnt("", f"{SCRIPT_NAME}: no theme set")

    else:
        weechat.prnt("", f"{SCRIPT_NAME}: commands:")
        weechat.prnt("", "  /theme list            — list available themes")
        weechat.prnt("", "  /theme apply <name>    — apply a theme")
        weechat.prnt("", "  /theme current         — show active theme")

    return weechat.WEECHAT_RC_OK


if __name__ == "__main__":
    weechat.register(
        SCRIPT_NAME, SCRIPT_AUTHOR, SCRIPT_VERSION, SCRIPT_LICENSE,
        SCRIPT_DESC, "", "",
    )

    # Default config: no active theme until user picks one
    if not weechat.config_is_set_plugin("active_theme"):
        weechat.config_set_plugin("active_theme", "")

    weechat.hook_command(
        "theme",
        "Load and apply color themes",
        "list | apply <name> | current",
        "  list: show available themes\n"
        " apply: apply a theme by name\n"
        "current: show which theme is active",
        "list || apply %(python_theme_names) || current",
        "theme_command_cb",
        "",
    )

    # Auto-apply on startup if a theme is configured
    active = get_active_theme()
    if active:
        weechat.prnt("", f"{SCRIPT_NAME}: auto-applying theme '{active}'")
        apply_theme(active, silent=True)
