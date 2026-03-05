# Yozakura (夜桜) Theme for WeeChat

Original theme inspired by **yozakura** — the Japanese tradition of viewing cherry blossoms at night, with paths lit by warm paper lanterns beneath canopies of pink petals.

## Design Concept

The palette captures the atmosphere of a nighttime hanami (花見) scene:

- **Cherry blossom pinks** — the heart of the theme, from soft sakura to vivid rose
- **Lantern gold** — the warm glow of chōchin (提灯) paper lanterns
- **Moonlight blue** — cool silvery light filtering through the branches
- **Spring green** — fresh new leaves emerging alongside the blossoms
- **Sage** — the quiet tones of moss and old garden stones
- **Dark night** — the deep sky behind the illuminated trees

## Canonical Yozakura Palette (256-color)

### Backgrounds (night sky with plum tint)

| Name | 256-color | Hex | Usage |
|------|-----------|-----|-------|
| bg0_h | 234 | `#1c1c1c` | Darkest — deepest night |
| bg0 | 235 | `#262626` | Main background, inactive bars |
| bg1 (plum) | 53 | `#5f005f` | **Bar backgrounds, separators, selections** |
| bg2 | 239 | `#4e4e4e` | Marked lines |
| bg3 | 241 | `#626262` | Inactive elements |

### Foregrounds (moonlit tones)

| Name | 256-color | Hex | Inspiration | Usage |
|------|-----------|-----|-------------|-------|
| fg0 | 224 | `#ffd7d7` | Petal white — blush-tinted | Brightest (selected items) |
| fg1 | 253 | `#dadada` | Moonlit white | Primary text |
| fg2 | 251 | `#c6c6c6` | Soft silver | Secondary text |
| fg4 | 249 | `#b2b2b2` | Stone gray | Muted text, delimiters |
| blush | 181 | `#d7afaf` | Pinkish gray | **Timestamps** |
| gray | 245 | `#8a8a8a` | Shadow | Comments, away nicks |
| inactive | 243 | `#767676` | Deep shadow | Inactive buffers |

### Accent Colors

| Name | 256-code | Hex | Inspiration | Usage |
|------|----------|-----|-------------|-------|
| Sakura Pink | 175 | `#d787af` | Cherry blossom (桜) | **Channels, buffers, nicks, values** |
| Rose | 168 | `#d75f87` | Deep petals | Errors, quits, kicks |
| Pale Pink | 217 | `#ffafaf` | Fallen petals | **Hosts, nick variety** |
| Hot Pink | 204 | `#ff5f87` | Full bloom close-up | Nick variety |
| Spring Green | 114 | `#87d787` | New leaves (若葉) | Joins, success, TLS ok |
| Sage | 108 | `#87af87` | Moss & garden stone | Hosts, values, topics |
| Lantern Gold | 222 | `#ffd787` | Paper lantern (提灯) | Highlights, warnings, nick self |
| Amber | 215 | `#ffaf5f` | Lantern flame | Read markers, changes |
| Moonlight | 110 | `#87afd7` | Moon through branches | Nick variety, secondary accent |
| Lavender | 183 | `#d7afff` | Wisteria (藤) | Alt purple |
| Branch Brown | 137 | `#af875f` | Cherry tree bark | Nick variety |

### Dim Accents (background use only)

| Name | 256-code | Hex | Usage |
|------|----------|-----|-------|
| Deep Rose | 53 | `#5f005f` | **Plum bar backgrounds, selections** |
| Dark Rose | 89 | `#87005f` | Alt highlight bg |

### Role Mapping

```
ROLE                               YOZAKURA         256-CODE
─────────────────────────────────  ───────────────  ────────
Primary text (fg1)                 Moonlit white    253
Bright text (fg0)                  Petal white      224
Secondary text (fg2)               Soft silver      251
Muted text (fg4)                   Stone gray       249
Gray / comments                    Shadow           245
Inactive text                      Deep shadow      243

Main background (bg0)              Night sky        235
Bar background (bg1)               Dark plum        53
Marked/secondary bg (bg2)          Lantern shadow   239
Inactive bg (bg3)                  Distant trees    241
Darkest bg (bg0_h)                 Deepest night    234

Red (→ Rose)                       Deep petals      168
Green (→ Spring)                   New leaves       114
Yellow (→ Gold)                    Paper lantern    222
Blue (→ Sakura)                  Cherry blossom   175
Purple (→ Sakura)                Cherry blossom   175
Aqua (→ Pale Pink)               Fallen petals    217
Orange (→ Amber)                   Lantern flame    215
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
/theme apply yozakura
```

This reads `commands.txt`, executes every `/set` command, and remembers the choice so it auto-applies on startup.

> **Note:** Your terminal background should be dark (`#1e1e2e` to `#2d2d2d`). The petal-tinted whites and soft pinks shine best against a true dark background — like blossoms against the night sky.
