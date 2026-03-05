# Catppuccin Mocha Theme for WeeChat

Ported from the [oh-my-posh catppuccin_mocha theme](https://github.com/JanDeDobbeleer/oh-my-posh/blob/main/themes/catppuccin_mocha.omp.json) using the [full Catppuccin Mocha palette](https://catppuccin.com/palette).

Catppuccin Mocha is the darkest variant of the Catppuccin pastel color scheme, featuring a cozy dark background with blue-tinted neutrals and rich, warm accent colors.

## Source Theme Color Analysis

The oh-my-posh theme defines a minimal palette (`os`, `pink`, `lavender`, `blue`) with foreground-only styling. The full Catppuccin Mocha palette (26 colors) was used to build a complete WeeChat theme.

| Segment | Foreground | Role |
|---------|-----------|------|
| OS | `#ACB0BE` (Overlay 2) | Shell indicator |
| Session | `#89B4FA` (Blue) | Session name |
| Path | `#F5C2E7` (Pink) | Current directory |
| Git | `#B4BEFE` (Lavender) | Repository status |

## Canonical Catppuccin Mocha Palette (256-color)

### Backgrounds (dark surface tones)

| Name | Hex | 256-color | Usage |
|------|-----|-----------|-------|
| Crust | `#11111b` | 233 | Darkest bg |
| Mantle | `#181825` | 234 | Inactive bars |
| Base | `#1e1e2e` | 235 | Main background |
| Surface 0 | `#313244` | 237 | Bar backgrounds, separators, selected lines |
| Surface 1 | `#45475a` | 239 | Marked lines, highlight bg |
| Surface 2 | `#585b70` | 241 | Inactive bg elements |

### Foregrounds (blue-tinted neutrals)

| Name | Hex | 256-color | Usage |
|------|-----|-----------|-------|
| Rosewater | `#f5e0dc` | 224 | Brightest (selected items) |
| Text | `#cdd6f4` | 189 | Primary text |
| Subtext 1 | `#bac2de` | 146 | Secondary text |
| Subtext 0 | `#a6adc8` | 247 | Tertiary text |
| Overlay 2 | `#9399b2` | 245 | Muted text, delimiters |
| Overlay 1 | `#7f849c` | 243 | Comments, away nicks, inactive |
| Overlay 0 | `#6c7086` | 241 | Very muted/disabled elements |

### Accent Colors

| Name | 256-color | Hex | Usage |
|------|-----------|-----|-------|
| Red | 211 | `#f38ba8` → `#ff87af` | Errors, quits, kicks |
| Maroon | 217 | `#eba0ac` → `#ffafaf` | Alt red (nick variety) |
| Green | 151 | `#a6e3a1` → `#afd7af` | Joins, success, TLS ok |
| Teal | 116 | `#94e2d5` → `#87d7d7` | Hosts, values, topics |
| Yellow | 223 | `#f9e2af` → `#ffd7af` | Highlights, warnings, nick self |
| Peach | 216 | `#fab387` → `#ffaf87` | Read markers, changes (orange role) |
| Blue | 111 | `#89b4fa` → `#87afff` | Channels, buffers, paths |
| Sapphire | 74 | `#74c7ec` → `#5fafd7` | Dim blue accents |
| Sky | 117 | `#89dceb` → `#87d7ff` | Alt cyan |
| Mauve | 183 | `#cba6f7` → `#d7afff` | Network, mode prefixes (purple role) |
| Lavender | 147 | `#b4befe` → `#afafff` | Alt purple |
| Pink | 218 | `#f5c2e7` → `#ffafd7` | Extra accent (nick variety) |
| Flamingo | 224 | `#f2cdcd` → `#ffd7d7` | Warm accent |

### Role Mapping

```
ROLE                               CATPPUCCIN   256-CODE
─────────────────────────────────  ──────────   ────────
Primary text (fg1)                 Text         189
Bright text (fg0)                  Rosewater    224
Secondary text (fg2)               Subtext 1    146
Muted text (fg4)                   Subtext 0    247
Gray / comments                    Overlay 2    245
Inactive text                      Overlay 1    243

Main background (bg0)              Base         235
Bar background (bg1)               Surface 0    237
Marked/secondary bg (bg2)          Surface 1    239
Inactive bg (bg3)                  Surface 2    241
Darkest bg (bg0_h)                 Mantle       234

Red                                Red          211
Green                              Green        151
Yellow                             Yellow       223
Blue                               Blue         111
Purple                             Mauve        183
Aqua                               Teal         116
Orange                             Peach        216
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
/theme apply catppuccin_mocha
```

This reads `commands.txt`, executes every `/set` command, and remembers the choice so it auto-applies on startup.

Alternatively, paste the commands manually or use `../../apply.sh catppuccin_mocha --docker` from the host shell.

> **Note:** Your terminal background should be set to `#1e1e2e` (Catppuccin Base) for the best result. Most Catppuccin terminal themes handle this automatically.
