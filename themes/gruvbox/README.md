# Gruvbox Theme for WeeChat

Ported from the [oh-my-posh gruvbox theme](https://github.com/JanDeDobbeleer/oh-my-posh/blob/main/themes/gruvbox.omp.json).

Gruvbox is a retro groove color scheme with warm, muted tones designed to be easy on the eyes during long sessions.

## Source Theme Color Analysis

The oh-my-posh gruvbox theme uses these key colors in its powerline segments:

| Segment | Background | Foreground | Role |
|---------|-----------|------------|------|
| OS | `#3A3A3A` | `#ffffff` | Dark neutral shell indicator |
| Path | `#458588` | `#282828` | **Gruvbox blue** for current directory |
| Git (clean) | `#98971A` | `#282828` | **Gruvbox green** for clean repo |
| Git (dirty) | `#FF9248` | `#282828` | Bright orange for uncommitted changes |
| Git (diverged) | `#ff4500` | `#282828` | Red-orange for diverged branches |
| Git (ahead/behind) | `#B388FF` | `#282828` | Light purple for sync status |
| Python | `#FFDE57` | `#111111` | Yellow for Python version |
| Ruby | `#AE1401` | `#ffffff` | Dark red for Ruby |
| Go | `#8ED1F7` | `#111111` | Light blue for Go |
| Root | `#ffff66` | `#111111` | Bright yellow warning for root |

## Canonical Gruvbox Palette (256-color)

The full gruvbox palette mapped to 256-color terminal codes used throughout WeeChat:

### Backgrounds

| Name | Hex | 256-color | Usage |
|------|-----|-----------|-------|
| bg0_h | `#1d2021` | 234 | Inactive bars |
| bg0 | `#282828` | 235 | Main background |
| bg0_s | `#32302f` | 236 | Subtle bg variation |
| bg1 | `#3c3836` | 237 | Bar backgrounds, separators, selected lines |
| bg2 | `#504945` | 239 | Marked lines, secondary bg |
| bg3 | `#665c54` | 241 | Muted/inactive elements |
| bg4 | `#7c6f64` | 243 | Inactive text, time delimiters |

### Foregrounds

| Name | Hex | 256-color | Usage |
|------|-----|-----------|-------|
| fg0 | `#fbf1c7` | 229 | Brightest text (selected items) |
| fg1 | `#ebdbb2` | 223 | Primary text |
| fg2 | `#d5c4a1` | 250 | Secondary text |
| fg3 | `#bdae93` | 248 | Tertiary text |
| fg4 | `#a89984` | 246 | Muted text, delimiters |
| gray | `#928374` | 245 | Comments, away nicks, inactive |

### Accent Colors

| Name | Normal (256) | Bright (256) | Usage |
|------|-------------|-------------|-------|
| Red | 124 | 167 | Errors, quits, kicks |
| Green | 100 | 142 | Joins, success, git clean |
| Yellow | 172 | 214 | Warnings, highlights, nick self |
| Blue | 66 | 109 | Paths, channels, buffers |
| Purple | 132 | 175 | Network, mode prefixes |
| Aqua | 72 | 108 | Hosts, values, topics |
| Orange | 166 | 208 | Read markers, changed values |

## Components Covered

The theme customizes every color-configurable WeeChat component:

- **Core chat area** — text, nicks, prefixes, timestamps, highlights, markers
- **Status bar** — numbers, names, hotlist counters, filters, modes
- **Title bar** — background and text colors
- **Input bar** — delimiter colors, action feedback
- **Buffer list** — current buffer highlight, hotlist indicators, numbers
- **Nick list** — groups, away status
- **Fset plugin** — all selection/highlight/value colors
- **IRC plugin** — join/quit/kick messages, nick prefixes, notices, topics

## How to Apply

From inside WeeChat:

```
/theme apply gruvbox
```

This reads `commands.txt`, executes every `/set` command, and remembers the choice so it auto-applies on startup.

Alternatively, paste the commands manually or use `../../apply.sh gruvbox --docker` from the host shell.

> **Note:** Your terminal background should be set to `#282828` (gruvbox bg0) for the best result. Most gruvbox terminal themes handle this automatically.
