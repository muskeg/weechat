# Frets On Fire

Inspired by the [fretsonfire.org](https://fretsonfire.org) community forum — deep maroon panels,
gold/yellow text, and fiery red accents on a dark stage.

## Palette

| Role            | Code | Hex       | Description          |
|-----------------|------|-----------|----------------------|
| Page background | default | (terminal) | Black stage        |
| Panel dark red  | 52   | `#5f0000` | Deep maroon panels   |
| Header red      | 88   | `#870000` | Title bar red        |
| Gold            | 220  | `#ffd700` | Links, channel names |
| Amber           | 178  | `#d7af00` | Secondary accent     |
| Orange          | 208  | `#ff8700` | Network, warnings    |
| Flame           | 202  | `#ff5f00` | Buffer numbers       |
| Red             | 160  | `#d70000` | Nick prefix, ops     |
| Bright red      | 196  | `#ff0000` | Errors, kicks        |
| Rust            | 131  | `#af5f5f` | Timestamps, dims     |
| Muted           | 95   | `#875f5f` | Inactive, day change |
| Green           | 71   | `#5faf5f` | Joins, TLS, filter   |
| Text            | 223  | `#ffd7af` | Warm light foreground|
| Bright text     | 230  | `#ffffd7` | Highlighted names    |
| Yellow          | 226  | `#ffff00` | Highlights, self nick|

## Design Notes

- **Title bar**: Bright maroon (88) — like the FoF section header bars
- **Nicklist / Input / Status**: Dark maroon (52) — the deep page background tone
- **Chat background**: `default` — stays with your terminal background
- **Separator**: Dark maroon (52) — subtle panel dividers
- **Timestamps**: Rust (131) — warm but unobtrusive
- **Nick colors**: All warm tones — golds, oranges, ambers, rusts (no blues/greens)
- **Links/channels**: Gold (220) — matching the forum's yellow link style
- **Errors/quits**: Red (160/196) — danger in fire
- **Joins/success**: Green (71) — the only cool color, for positive events

## Screenshot Inspiration

The fretsonfire.org phpBB forum features:
- Nearly-black background with deep red undertones
- Red section header bars
- Yellow/gold links and topic titles
- Warm gray body text
- Fire-themed throughout
