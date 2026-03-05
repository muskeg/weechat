# Carbon Theme for WeeChat

Sleek, modern dark theme designed for true-black terminals and OLED displays. Electric blue accents on a pure black canvas with a cool steel foreground scale.

## Design Concept

Carbon is built around two principles:

1. **OLED-friendly** — uses `default` (terminal black) for all main backgrounds, so true-black terminals and OLED screens render perfect black pixels with zero light bleed
2. **Modern minimalism** — a tight accent palette dominated by electric blue, with cyan, purple, and warm tones used sparingly for status differentiation

The aesthetic is inspired by modern dark IDE themes and carbon fiber dashboards — clean lines, high contrast, no visual noise.

## Canonical Carbon Palette (256-color)

### Backgrounds (true black core)

| Name | 256-color | Hex | Usage |
|------|-----------|-----|-------|
| bg0 | default | Terminal black | Main background (OLED black) |
| bg1 | 234 | `#1c1c1c` | Bar backgrounds, separators |
| bg1_inactive | 232 | `#080808` | Inactive bars (near-black) |
| bg2 | 236 | `#303030` | Marked lines, search bg |
| bg3 | 238 | `#444444` | Inactive elements |

### Foregrounds (cool steel)

| Name | 256-color | Hex | Usage |
|------|-----------|-----|-------|
| fg0 | 255 | `#eeeeee` | Brightest (selected, name) |
| fg1 | 252 | `#d0d0d0` | Primary text |
| fg2 | 249 | `#b2b2b2` | Secondary text |
| fg4 | 245 | `#8a8a8a` | Muted text, timestamps, delimiters |
| gray | 242 | `#6c6c6c` | Comments, away nicks |
| dim | 239 | `#4e4e4e` | Inactive windows |

### Accent Colors

| Name | 256-code | Hex | Role |
|------|----------|-----|------|
| Electric Blue | 75 | `#5fafff` | **Primary accent** — channels, buffers, nicks, numbers |
| Cyan | 80 | `#5fd7d7` | Hosts, values, secondary accent |
| Ice | 117 | `#87d7ff` | Self nick, bright highlight |
| Red | 203 | `#ff5f5f` | Errors, quits, kicks |
| Green | 78 | `#5fd787` | Joins, success, TLS ok |
| Yellow | 221 | `#ffd75f` | Warnings, highlights, changes |
| Orange | 209 | `#ff875f` | Read markers |
| Purple | 141 | `#af87ff` | Network, mode prefixes, types |

### Dim Accents (background use only)

| Name | 256-code | Hex | Usage |
|------|----------|-----|-------|
| Deep Blue | 23 | `#005f5f` | Search/emphasis bg |
| Deep Purple | 54 | `#5f0087` | Alt highlight bg |

### Role Mapping

```
ROLE                               CARBON           256-CODE
─────────────────────────────────  ───────────────  ────────
Primary text (fg1)                 Steel            252
Bright text (fg0)                  Bright steel     255
Secondary text (fg2)               Mid steel        249
Muted text (fg4)                   Dim steel        245
Gray / comments                    Gray             242
Inactive text                      Dark             239

Main background (bg0)              True black       default
Bar background (bg1)               Near black       234
Marked/secondary bg (bg2)          Dark gray        236
Inactive bg (bg3)                  Mid gray         238
Darkest bg (bg0_h)                 Deepest black    232

Red                                Neon red         203
Green                              Neon green       78
Yellow                             Warm yellow      221
Blue                               Electric blue    75
Purple                             Violet           141
Aqua                               Cyan             80
Orange                             Ember            209
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
/theme apply carbon
```

## OLED Notes

- The chat area, input bar, buflist, and nicklist all use `default` background — your terminal's native black
- Bar strips (status, title) use 234 (`#1c1c1c`) — just barely visible against true black, creating subtle separation without bright borders
- On OLED phones, the majority of the screen will be true black pixels (off), saving battery
- For best results, ensure your terminal app uses `#000000` as its background color
