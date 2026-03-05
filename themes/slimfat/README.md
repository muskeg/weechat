# Slimfat Theme for WeeChat

Ported from the [oh-my-posh slimfat theme](https://github.com/JanDeDobbeleer/oh-my-posh/blob/main/themes/slimfat.omp.json).

Slimfat is a high-contrast cyberpunk/neon dark theme featuring bright cyan, mint, and yellow accents on a neutral dark gray base. It has a modern, tech-forward aesthetic with vivid saturated colors.

## Source Theme Color Analysis

The oh-my-posh theme uses a uniform dark background (`#2f2f2f`) across all segments with bright neon foreground colors:

| Segment | Foreground | Hex | Role |
|---------|-----------|-----|------|
| OS | Cyan | `#26C6DA` | Shell indicator icon |
| Session (user) | Mint | `#77f5d6` | Username |
| Session (host) | Emerald | `#2EEFBF` | Hostname |
| Root | Bright yellow | `#ffff66` | Root warning |
| Path (icon) | Yellow | `#f2f200` | Folder icon |
| Path (text) | White | `#fafafa` | Directory path |
| Git (dirty) | Golden | `#ffeb3b` | Uncommitted changes |
| Git (ahead) | Teal | `#2EC4B6` | Ahead of remote |
| Git (behind) | Purple | `#8A4FFF` | Behind remote |
| Git (working) | Red | `#E84855` | Working tree changes |
| Git (staging) | Green | `#2FDA4E` | Staged changes |
| Node | Olive | `#6CA35E` | Node.js version |
| Python | Lime | `#96E072` | Python version |
| .NET | Dark teal | `#3891A6` | .NET version |
| Time | Blue | `#007ACC` | VS Code blue icon |
| Exec time | Gold | `#FFCE5C` | Command duration |
| Status (ok) | Lime | `#9FD356` | Exit code 0 |
| Status (error) | Red | `#E84855` | Non-zero exit |
| Separators | Gray | `#7a7a7a` | Powerline dividers |

## Canonical Slimfat Palette (256-color)

### Backgrounds (neutral grays)

| Name | Hex | 256-color | Usage |
|------|-----|-----------|-------|
| bg0_h | `#262626` | 235 | Darkest bg, inactive bars |
| bg0 | `#2f2f2f` | 236 | Main background |
| bg1 | `#3a3a3a` | 237 | Bar backgrounds, separators, selected lines |
| bg2 | `#4e4e4e` | 239 | Marked lines, highlight bg |
| bg3 | `#626262` | 241 | Inactive bg elements |

### Foregrounds (neutral whites)

| Name | Hex | 256-color | Usage |
|------|-----|-----------|-------|
| fg0 | `#ffffff` | 231 | Brightest (selected items, search results) |
| fg1 | `#eeeeee` | 255 | Primary text |
| fg2 | `#d0d0d0` | 252 | Secondary text |
| fg4 | `#b2b2b2` | 249 | Muted text, delimiters, timestamps |
| gray | `#767676` | 243 | Comments, away nicks, separators |
| inactive | `#626262` | 241 | Inactive elements |

### Accent Colors

| Name | 256-color | Hex | Source | Usage |
|------|-----------|-----|--------|-------|
| Cyan | 80 | `#5fd7d7` | `#26C6DA` | Channels, buffers, paths (blue role) |
| Mint | 86 | `#5fffd7` | `#2EEFBF` | Hosts, values, topics (aqua role) |
| Yellow | 227 | `#ffff5f` | `#ffff66` | Highlights, warnings, nick self |
| Gold | 221 | `#ffd75f` | `#FFCE5C` | Read markers, changes (orange role) |
| Red | 203 | `#ff5f5f` | `#E84855` | Errors, quits, kicks |
| Green | 77 | `#5fd75f` | `#2FDA4E` | Joins, success, TLS ok |
| Purple | 99 | `#875fff` | `#8A4FFF` | Network, mode prefixes |
| Lime | 149 | `#afd75f` | `#9FD356` | Alt green (nick variety) |
| Olive | 71 | `#5faf5f` | `#6CA35E` | Alt green (nick variety) |

### Role Mapping

```
ROLE                               SLIMFAT      256-CODE
─────────────────────────────────  ───────────  ────────
Primary text (fg1)                 White        255
Bright text (fg0)                  Pure white   231
Secondary text (fg2)               Light gray   252
Muted text (fg4)                   Mid gray     249
Gray / comments                    Gray         243
Inactive text                      Dark gray    241

Main background (bg0)              Dark gray    236
Bar background (bg1)               Gray         237
Marked/secondary bg (bg2)          Mid gray     239
Inactive bg (bg3)                  Gray         241
Darkest bg (bg0_h)                 Charcoal     235

Red                                Neon red     203
Green                              Neon green   77
Yellow                             Neon yellow  227
Blue (→ Cyan)                      Neon cyan    80
Purple                             Vivid purple 99
Aqua (→ Mint)                      Neon mint    86
Orange (→ Gold)                    Warm gold    221
```

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
/theme apply slimfat
```

This reads `commands.txt`, executes every `/set` command, and remembers the choice so it auto-applies on startup.

Alternatively, paste the commands manually or use `../../apply.sh slimfat --docker` from the host shell.

> **Note:** Your terminal background should be set to `#2f2f2f` or similar dark gray for the best result. Slimfat is designed for high contrast — the neon accents pop best against a neutral dark background.
