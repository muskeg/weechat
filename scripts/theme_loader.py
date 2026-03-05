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
#   /theme reset           — undo theme, restore WeeChat defaults
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
SCRIPT_VERSION = "1.1"
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


def parse_theme_options(name):
    """Return a list of (option_name, value) from a theme's commands.txt."""
    commands_file = os.path.join(THEMES_DIR, name, "commands.txt")
    if not os.path.isfile(commands_file):
        return None
    options = []
    with open(commands_file, "r", encoding="utf-8") as f:
        for line in f:
            line = line.strip()
            if not line or line.startswith("#"):
                continue
            if line.startswith("/set "):
                parts = line.split(None, 2)
                if len(parts) >= 3:
                    options.append((parts[1], parts[2]))
                elif len(parts) == 2:
                    options.append((parts[1], ""))
    return options


def apply_theme(name, silent=False):
    """Parse commands.txt for a theme and execute every /set and /save line."""
    options = parse_theme_options(name)
    if options is None:
        commands_file = os.path.join(THEMES_DIR, name, "commands.txt")
        weechat.prnt("", f"{SCRIPT_NAME}: theme '{name}' not found "
                         f"(no {commands_file})")
        return False

    count = 0
    for opt_name, opt_value in options:
        weechat.command("", f"/set {opt_name} {opt_value}")
        count += 1
    weechat.command("", "/save")

    set_active_theme(name)
    if not silent:
        weechat.prnt("", f"{SCRIPT_NAME}: applied theme '{name}' "
                         f"({count} settings)")
    return True


def reset_theme(silent=False):
    """Undo the active theme by resetting all themed options to defaults."""
    active = get_active_theme()
    if not active:
        if not silent:
            weechat.prnt("", f"{SCRIPT_NAME}: no active theme to reset")
        return False

    options = parse_theme_options(active)
    if options is None:
        # Theme files missing — fall back to blanket unsets
        for prefix in ("weechat.color.", "weechat.bar.",
                       "irc.color.", "buflist.format.", "fset.color."):
            weechat.command("", f"/unset -mask {prefix}*")
        weechat.command("", "/save")
        set_active_theme("")
        if not silent:
            weechat.prnt("", f"{SCRIPT_NAME}: reset all color options "
                             f"(theme files not found, used blanket unset)")
        return True

    count = 0
    for opt_name, _ in options:
        weechat.command("", f"/unset {opt_name}")
        count += 1
    weechat.command("", "/save")

    set_active_theme("")
    if not silent:
        weechat.prnt("", f"{SCRIPT_NAME}: reset {count} options to defaults "
                         f"(was: {active})")
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

    elif subcmd == "reset":
        reset_theme()

    elif subcmd == "current":
        active = get_active_theme()
        if active:
            weechat.prnt("", f"{SCRIPT_NAME}: active theme: {active}")
        else:
            weechat.prnt("", f"{SCRIPT_NAME}: no theme set (defaults)")

    else:
        weechat.prnt("", f"{SCRIPT_NAME}: commands:")
        weechat.prnt("", "  /theme list            — list available themes")
        weechat.prnt("", "  /theme apply <name>    — apply a theme")
        weechat.prnt("", "  /theme reset           — undo theme, restore defaults")
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
        "list | apply <name> | reset | current",
        "  list: show available themes\n"
        " apply: apply a theme by name\n"
        " reset: undo the active theme, restore WeeChat defaults\n"
        "current: show which theme is active",
        "list || apply %(python_theme_names) || reset || current",
        "theme_command_cb",
        "",
    )

    # Auto-apply on startup if a theme is configured
    active = get_active_theme()
    if active:
        weechat.prnt("", f"{SCRIPT_NAME}: auto-applying theme '{active}'")
        apply_theme(active, silent=True)
