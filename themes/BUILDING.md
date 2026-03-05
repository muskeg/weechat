# Theme Building Specification

This document describes the exact process for building a new WeeChat color theme
from a source theme (e.g., an oh-my-posh `.omp.json`, a terminal theme, or any
color palette). It is written so that an AI agent or human can follow it
step-by-step to produce a complete, working theme.

---

## Prerequisites

- Access to the source theme's color palette (hex values)
- Familiarity with 256-color terminal codes
- The reference theme at `themes/gruvbox/` as a structural template

---

## Step 1 — Obtain the Source Palette

Fetch or read the source theme file. Extract every distinct color (hex).

For oh-my-posh themes, the colors are in:
- `segments[].background`
- `segments[].foreground`
- `segments[].background_templates[]`

Group them by role:
- **Backgrounds**: darkest to lightest (typically 4–6 shades)
- **Foregrounds**: brightest to most muted (typically 4–6 shades)
- **Accents**: red, green, yellow, blue, purple, aqua/cyan, orange (each with
  a normal and bright variant if available)

**CRITICAL — Dark vs Bright accent variants:**

Most color schemes define two variants per accent: a **normal** (dark) and a
**bright** one. For dark-background themes, **always use the bright variant for
foreground text**. The normal/dark variants (e.g., gruvbox blue #458588 = 66,
green #98971a = 100, red #cc241d = 124) are nearly invisible on a dark terminal
and will appear as black-on-black. Reserve dark variants ONLY for:
- Background colors (highlight backgrounds, bar backgrounds)
- Separator lines
- Elements that sit on a light background

Rule of thumb: if a 256-color code's hex value has no channel above `#af`,
it's too dark for foreground use on a dark terminal.

## Step 2 — Map Hex Colors to 256-Color Terminal Codes

WeeChat uses 256-color codes (0–255). Convert each hex color to its nearest
256-color match.

### Conversion reference

Use this algorithm or a lookup table:

| Range | Codes | Description |
|-------|-------|-------------|
| 0–7 | Standard colors | black, red, green, yellow, blue, magenta, cyan, white |
| 8–15 | Bright colors | bright black through bright white |
| 16–231 | 6×6×6 color cube | `16 + 36*r + 6*g + b` where r,g,b ∈ {0..5} |
| 232–255 | Grayscale ramp | 24 shades from dark (#080808) to light (#eeeeee) |

For quick conversion: `round(component / 255 * 5)` for each R, G, B channel,
then `16 + 36*r + 6*g + b`.

### Example mapping (gruvbox)

```
#282828 → 235 (bg0)        #ebdbb2 → 223 (fg1)
#3c3836 → 237 (bg1)        #fbf1c7 → 229 (fg0)
#504945 → 239 (bg2)        #a89984 → 246 (fg4)
#665c54 → 241 (bg3)        #928374 → 245 (gray)
```

## Step 3 — Define the Role Assignments

Map your palette to WeeChat's semantic roles. Every theme MUST assign all of the
roles below. Use the palette responsibly — typically:

- **Primary text** → fg1 (main foreground)
- **Bright/selected** → fg0 (brightest foreground)
- **Muted/inactive** → fg4, gray, or bg4
- **Bar backgrounds** → bg1 (one step lighter than main bg)
- **Inactive bar bg** → bg0_h or bg0 (darkest)
- **Separators** → bg1
- **Highlights/warnings** → bright accent (yellow, orange)
- **Errors/quits/kicks** → bright red
- **Joins/success/enabled** → bright green
- **Channels/buffers/paths** → bright blue
- **Network/prefixes** → purple
- **Hosts/values/topics** → aqua
- **Read markers/changes** → orange
- **Nick self** → bright yellow or bright accent

### Complete role table

This is the canonical mapping. Copy this table for your theme README and fill
in the 256-color codes from your palette.

```
ROLE                               GRUVBOX   YOUR THEME
─────────────────────────────────  ────────  ──────────
Primary text (fg1)                 223       ???
Bright text (fg0)                  229       ???
Secondary text (fg2)               250       ???
Muted text (fg4)                   246       ???
Gray / comments                    245       ???
Inactive text (bg4)                243       ???

Main background (bg0)              235       ???
Bar background (bg1)               237       ???
Marked/secondary bg (bg2)          239       ???
Inactive bg (bg3)                  241       ???
Darkest bg (bg0_h)                 234       ???

Red (normal / bright)              124/167   ???/???
Green (normal / bright)            100/142   ???/???
Yellow (normal / bright)           172/214   ???/???
Blue (normal / bright)             66/109    ???/???
Purple (normal / bright)           132/175   ???/???
Aqua (normal / bright)             72/108    ???/???
Orange (normal / bright)           166/208   ???/???
```

## Step 4 — Build `commands.txt`

Generate the file with ALL sections below. Use the role assignments from Step 3.
The file MUST:

1. Start with a header comment block including the palette reference
2. Group commands by section with comment headers
3. End with `/save`
4. Use ONLY `/set` commands (the `theme_loader.py` script only executes `/set`
   and `/save` for safety)

### Section: Core Chat Colors

These control the main chat area text, nicks, timestamps, and decorations.

```
/set weechat.color.chat <fg1>
/set weechat.color.chat_bg <bg0>
/set weechat.color.chat_buffer <bright_blue>
/set weechat.color.chat_channel <bright_blue>
/set weechat.color.chat_day_change <gray>
/set weechat.color.chat_delimiters <fg4>
/set weechat.color.chat_highlight <bright_yellow>
/set weechat.color.chat_highlight_bg <red>
/set weechat.color.chat_host <bright_aqua>
/set weechat.color.chat_inactive_buffer <bg4>
/set weechat.color.chat_inactive_window <bg3>
/set weechat.color.chat_nick <bright_blue>
/set weechat.color.chat_nick_colors "<comma-separated list of accent codes>"
/set weechat.color.chat_nick_offline <bg4>
/set weechat.color.chat_nick_offline_highlight <bright_yellow>
/set weechat.color.chat_nick_offline_highlight_bg <bg2>
/set weechat.color.chat_nick_other <bright_aqua>
/set weechat.color.chat_nick_prefix <bright_green>
/set weechat.color.chat_nick_self <bright_yellow>
/set weechat.color.chat_nick_suffix <bright_green>
/set weechat.color.chat_prefix_action <fg1>
/set weechat.color.chat_prefix_buffer <bright_yellow>
/set weechat.color.chat_prefix_buffer_inactive_buffer <bg4>
/set weechat.color.chat_prefix_error <bright_red>
/set weechat.color.chat_prefix_join <bright_green>
/set weechat.color.chat_prefix_more <bright_purple>
/set weechat.color.chat_prefix_network <bright_purple>
/set weechat.color.chat_prefix_quit <bright_red>
/set weechat.color.chat_prefix_suffix <blue>
/set weechat.color.chat_read_marker <bright_orange>
/set weechat.color.chat_read_marker_bg default
/set weechat.color.chat_server <yellow>
/set weechat.color.chat_status_disabled <bright_red>
/set weechat.color.chat_status_enabled <bright_green>
/set weechat.color.chat_tags <gray>
/set weechat.color.chat_text_found <bright_yellow>
/set weechat.color.chat_text_found_bg <purple>
/set weechat.color.chat_time <fg4>
/set weechat.color.chat_time_delimiters <bg4>
/set weechat.color.chat_value <bright_aqua>
/set weechat.color.chat_value_null <bright_purple>
/set weechat.color.emphasized <bright_yellow>
/set weechat.color.emphasized_bg <purple>
/set weechat.color.eval_syntax_colors "<bright_green>,<bright_red>,<bright_blue>,<bright_purple>,<bright_yellow>,<bright_aqua>"
```

### Section: Input & Misc UI

```
/set weechat.color.input_actions <bright_green>
/set weechat.color.input_text_not_found <bright_red>
/set weechat.color.item_away <bright_yellow>
/set weechat.color.nicklist_away <gray>
/set weechat.color.nicklist_group <bright_green>
/set weechat.color.separator <bg1>
/set weechat.color.bar_more <bright_purple>
```

### Section: Status Bar

```
/set weechat.color.status_count_highlight <bright_purple>
/set weechat.color.status_count_msg <yellow>
/set weechat.color.status_count_other <fg4>
/set weechat.color.status_count_private <bright_green>
/set weechat.color.status_data_highlight <bright_purple>
/set weechat.color.status_data_msg <bright_yellow>
/set weechat.color.status_data_other <fg4>
/set weechat.color.status_data_private <bright_green>
/set weechat.color.status_filter <bright_green>
/set weechat.color.status_modes <fg1>
/set weechat.color.status_more <bright_yellow>
/set weechat.color.status_mouse <bright_green>
/set weechat.color.status_name <fg1>
/set weechat.color.status_name_insecure <bright_red>
/set weechat.color.status_name_tls <bright_green>
/set weechat.color.status_nicklist_count <fg4>
/set weechat.color.status_number <bright_yellow>
/set weechat.color.status_time <fg4>
```

### Section: Bar Backgrounds & Foregrounds

Set for each bar: `status`, `title`, `input`, `nicklist`, `buflist`, `fset`.

```
/set weechat.bar.<name>.color_bg <bg1>          # (input: use default)
/set weechat.bar.<name>.color_bg_inactive <bg0>  # (input: use default)
/set weechat.bar.<name>.color_fg <fg1>           # (input: use default)
/set weechat.bar.<name>.color_delim <fg4>
```

Note: `input` bar should use `default` for bg/fg to inherit terminal colors.
`buflist` and `nicklist` bars should use `default` for bg.

### Section: IRC Plugin Colors

```
/set irc.color.input_nick <bright_yellow>
/set irc.color.item_lag_counting <fg4>
/set irc.color.item_lag_finished <bright_yellow>
/set irc.color.item_nick_modes <fg4>
/set irc.color.item_tls_version_deprecated <yellow>
/set irc.color.item_tls_version_insecure <bright_red>
/set irc.color.item_tls_version_ok <bright_green>
/set irc.color.list_buffer_line_selected <fg1>
/set irc.color.list_buffer_line_selected_bg <bg1>
/set irc.color.message_account <bright_aqua>
/set irc.color.message_chghost <yellow>
/set irc.color.message_join <bright_green>
/set irc.color.message_kick <bright_red>
/set irc.color.message_quit <bright_red>
/set irc.color.message_setname <yellow>
/set irc.color.nick_prefixes "y:<bright_red>;q:<bright_red>;a:<bright_blue>;o:<bright_green>;h:<bright_purple>;v:<bright_yellow>;*:<blue>"
/set irc.color.notice <bright_green>
/set irc.color.reason_kick <fg4>
/set irc.color.reason_quit <fg4>
/set irc.color.topic_current <fg1>
/set irc.color.topic_new <bright_aqua>
/set irc.color.topic_old <gray>
```

### Section: Buflist Formats

```
/set buflist.format.buffer "${format_number}${indent}${format_nick_prefix}${color_hotlist}${format_name}"
/set buflist.format.buffer_current "${color:,<bg1>}${format_buffer}"
/set buflist.format.hotlist " ${color:<bright_green>}(${hotlist}${color:<bright_green>})"
/set buflist.format.hotlist_highlight "${color:<bright_purple>}"
/set buflist.format.hotlist_low "${color:<fg4>}"
/set buflist.format.hotlist_message "${color:<yellow>}"
/set buflist.format.hotlist_none "${color:<fg1>}"
/set buflist.format.hotlist_private "${color:<bright_green>}"
/set buflist.format.hotlist_separator "${color:<fg4>},"
/set buflist.format.lag " ${color:<bright_green>}[${color:<yellow>}${lag}${color:<bright_green>}]"
/set buflist.format.number "${color:<bright_yellow>}${number}${if:${number_displayed}?.: }"
```

### Section: Fset Plugin Colors

The fset plugin has many color options. Every option follows a pattern:
- Normal state → `<fg4>` or `<fg1>` (for primary text)
- Selected state → `<fg0>` or `<fg1>` (brighter)
- Changed state → `<yellow>` or `<bright_yellow>`
- Changed+selected → `<bright_yellow>`
- Backgrounds → `<bg1>` for selected, `<bg2>` for marked

Full list (every fset.color.* option must be set):

```
/set fset.color.allowed_values <fg4>
/set fset.color.allowed_values_selected <fg1>
/set fset.color.color_name <fg4>
/set fset.color.color_name_selected <fg1>
/set fset.color.default_value <fg4>
/set fset.color.default_value_selected <fg1>
/set fset.color.description <gray>
/set fset.color.description_selected <fg1>
/set fset.color.file <fg4>
/set fset.color.file_changed <yellow>
/set fset.color.file_changed_selected <bright_yellow>
/set fset.color.file_selected <fg1>
/set fset.color.help_default_value <fg1>
/set fset.color.help_description <fg1>
/set fset.color.help_name <fg1>
/set fset.color.help_quotes <bg3>
/set fset.color.help_values <fg1>
/set fset.color.index <bright_aqua>
/set fset.color.index_selected <bright_blue>
/set fset.color.line_marked_bg1 <bg2>
/set fset.color.line_marked_bg2 <bg2>
/set fset.color.line_selected_bg1 <bg1>
/set fset.color.line_selected_bg2 <bg1>
/set fset.color.marked <yellow>
/set fset.color.marked_selected <bright_yellow>
/set fset.color.max <fg4>
/set fset.color.max_selected <fg1>
/set fset.color.min <fg4>
/set fset.color.min_selected <fg1>
/set fset.color.name <fg1>
/set fset.color.name_changed <bright_yellow>
/set fset.color.name_changed_selected <bright_yellow>
/set fset.color.name_selected <fg0>
/set fset.color.option <fg1>
/set fset.color.option_changed <yellow>
/set fset.color.option_changed_selected <bright_yellow>
/set fset.color.option_selected <fg0>
/set fset.color.parent_name <fg4>
/set fset.color.parent_name_selected <fg1>
/set fset.color.parent_value <bright_aqua>
/set fset.color.parent_value_selected <bright_blue>
/set fset.color.quotes <bg3>
/set fset.color.quotes_changed <fg4>
/set fset.color.quotes_changed_selected <fg1>
/set fset.color.quotes_selected <fg4>
/set fset.color.section <fg4>
/set fset.color.section_changed <yellow>
/set fset.color.section_changed_selected <bright_yellow>
/set fset.color.section_selected <fg1>
/set fset.color.string_values <fg4>
/set fset.color.string_values_selected <fg1>
/set fset.color.title_count_options <bright_aqua>
/set fset.color.title_current_option <bright_blue>
/set fset.color.title_filter <bright_yellow>
/set fset.color.title_marked_options <bright_green>
/set fset.color.title_sort <fg1>
/set fset.color.type <purple>
/set fset.color.type_selected <bright_purple>
/set fset.color.unmarked <fg4>
/set fset.color.unmarked_selected <fg1>
/set fset.color.value <bright_aqua>
/set fset.color.value_changed <bright_yellow>
/set fset.color.value_changed_selected <bright_yellow>
/set fset.color.value_selected <bright_blue>
/set fset.color.value_undef <bright_purple>
/set fset.color.value_undef_selected <bright_purple>
```

### Section: Save

Always end with:

```
/save
```

## Step 5 — Build the Theme README

Create `themes/<name>/README.md` with:

1. **Title and source link** — where the palette came from
2. **Source theme color analysis** — table of colors extracted from the source
3. **Canonical palette** — tables for backgrounds, foregrounds, and accents with
   hex values, 256-color codes, and usage descriptions
4. **Components covered** — bullet list of all WeeChat areas themed
5. **How to apply** — the `/theme apply <name>` command
6. **Terminal background note** — what hex color the terminal bg should be

Use `themes/gruvbox/README.md` as the structural template.

## Step 6 — Update the Top-Level README

Add a row to the table in `themes/README.md`:

```markdown
| [name](name/) | [source link](url) | Short description |
```

## Step 7 — Validate

Checklist before committing:

- [ ] `commands.txt` has no duplicate keys
- [ ] Every `/set` line in the template above has a corresponding line in
      `commands.txt` (no missing settings)
- [ ] All color values are valid 256-color codes (0–255) or `default`
- [ ] `chat_nick_colors` is a quoted comma-separated list of accent codes
      (use all normal+bright accents for variety)
- [ ] `nick_prefixes` is a quoted semicolon-separated list in format
      `mode:color` covering y, q, a, o, h, v, *
- [ ] `eval_syntax_colors` is a quoted comma-separated list of 6 accent codes
- [ ] `buflist.format.*` strings use `${color:<code>}` syntax (not raw codes)
- [ ] The file ends with `/save`
- [ ] README.md exists with palette tables and apply instructions
- [ ] `themes/README.md` table is updated
- [ ] No `/unset`, `/exec`, `/trigger`, or other non-`/set` commands (except
      `/save`) — the `theme_loader.py` script only executes `/set` and `/save`

---

## Quick Reference — All 256-Color Options Set by a Theme

Total: **~140 `/set` commands** across these config sections:

| Section | Key prefix | Count |
|---------|-----------|-------|
| Core chat | `weechat.color.chat_*` | ~35 |
| Emphasis/eval | `weechat.color.emphasized*`, `eval_*` | 3 |
| Input/UI | `weechat.color.input_*`, `item_*`, `nicklist_*`, `separator`, `bar_more` | 7 |
| Status bar | `weechat.color.status_*` | 18 |
| Bar colors | `weechat.bar.*.color_*` | ~24 (6 bars × 4 props) |
| IRC | `irc.color.*` | ~20 |
| Buflist | `buflist.format.*` | ~10 |
| Fset | `fset.color.*` | ~48 |

---

## Source Theme Locations

Common places to find theme palettes:

- **oh-my-posh**: `https://raw.githubusercontent.com/JanDeDobbeleer/oh-my-posh/refs/heads/main/themes/<name>.omp.json`
- **base16**: `https://github.com/tinted-theming/base16-schemes/blob/main/<name>.yaml`
- **terminal.sexy**: `https://terminal.sexy/` (export as JSON)
- **gogh**: `https://github.com/Gogh-Co/Gogh/tree/master/themes`
- **iTerm2-Color-Schemes**: `https://github.com/mbadolato/iTerm2-Color-Schemes`
