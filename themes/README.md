# WeeChat Themes

Custom color themes for WeeChat, ported from popular terminal/shell themes.

## Available Themes

| Theme | Source | Description |
|-------|--------|-------------|
| [gruvbox](gruvbox/) | [oh-my-posh gruvbox](https://github.com/JanDeDobbeleer/oh-my-posh/blob/main/themes/gruvbox.omp.json) | Warm retro groove colorscheme |
| [catppuccin_mocha](catppuccin_mocha/) | [oh-my-posh catppuccin_mocha](https://github.com/JanDeDobbeleer/oh-my-posh/blob/main/themes/catppuccin_mocha.omp.json) | Cozy pastel dark theme with blue-tinted neutrals |

## How to Apply a Theme

Each theme folder contains:

- **README.md** — Color analysis, palette reference, and usage notes
- **commands.txt** — All `/set` commands to apply the theme

### Inside WeeChat (recommended)

The `theme_loader.py` script (auto-loaded from `scripts/`) provides a `/theme` command:

```
/theme list              — show available themes
/theme apply gruvbox     — apply the gruvbox theme
/theme current           — show which theme is active
```

Once applied, the active theme is remembered and **auto-applied on every WeeChat startup**.

### Shell: apply.sh (FIFO pipe)

Use the included `apply.sh` script to send commands through WeeChat's FIFO pipe from outside:

```bash
# If WeeChat runs in Docker (container name: weechat)
./themes/apply.sh gruvbox --docker

# If WeeChat runs on the host
./themes/apply.sh gruvbox
```

### Alternative: Paste in WeeChat

You can also paste the commands manually. To strip the comments first:

```bash
grep -v '^\s*#' themes/gruvbox/commands.txt | grep -v '^\s*$'
```

Copy the output and paste it into WeeChat's input bar.

### Alternative: FIFO one-liner

If you prefer a one-liner without the script:

```bash
# Host
FIFO=$(ls /tmp/weechat_fifo_* 2>/dev/null | head -1) && \
  grep -v '^\s*#' themes/gruvbox/commands.txt | grep -v '^\s*$' | \
  while read cmd; do echo "* $cmd" > "$FIFO"; done

# Docker
FIFO=$(docker exec weechat sh -c 'ls /tmp/weechat_fifo_* 2>/dev/null | head -1') && \
  grep -v '^\s*#' themes/gruvbox/commands.txt | grep -v '^\s*$' | \
  while read cmd; do docker exec weechat sh -c "echo '* $cmd' > $FIFO"; done
```

### Reset to Defaults

To undo a theme, you can reset individual settings:

```
/unset weechat.color.*
/unset irc.color.*
/unset buflist.format.*
/unset fset.color.*
/save
```

## Adding a New Theme

1. Create a new folder under `themes/` named after the theme
2. Add a `README.md` with color analysis and palette mapping
3. Add a `commands.txt` with all the `/set` commands
4. Commit and push
