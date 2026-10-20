# Afterglow for spotatui

Custom theme using the Afterglow Remastered palette shared by
[`nvim/lua/explorer.lua`](../nvim/lua/explorer.lua) and
[`yazi/flavors/afterglow.yazi/flavor.toml`](../yazi/flavors/afterglow.yazi/flavor.toml).
Colors use explicit RGB strings as required by the
[spotatui theme documentation](https://github.com/LargeModGames/spotatui/blob/main/docs/themes.md).

| Color | Hex | Use |
| --- | --- | --- |
| Charcoal | `#2e2e2e` | Background, text on filled bars |
| Dark charcoal | `#292929` | Playbar background |
| Light gray | `#d6d6d6` | Text |
| Muted gray | `#979797` | Inactive elements |
| Warm orange | `#ffc66d` | Banner, hovered items, highlighted lyrics |
| Muted blue | `#6c99bb` | Selection, headers |
| Green | `#b4c973` | Playing track, playback progress |
| Magenta | `#a1617a` | Hints |
| Rust red | `#c45837` | Errors |
| Cyan | `#7fb9cf` | Analysis bar |

## Apply

1. Quit spotatui so it cannot overwrite your changes when saving settings.
2. Back up your existing `config.yml` in `~/.config/spotatui` (or
   `$XDG_CONFIG_HOME/spotatui` if `XDG_CONFIG_HOME` is an absolute path).
3. Replace only its `theme:` block with the block from [`config.yml`](config.yml),
   preserving all other settings. If no config exists, copy this file there.
4. Restart spotatui. Keep the preset set to **Custom**; named presets ignore
   the custom colors.

This file is a theme template, not a replacement for your complete app config.
It is intentionally not symlinked by `install.sh` because spotatui saves other
settings into the same file.
