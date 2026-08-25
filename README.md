# kenkyo-zmk-config

A ZMK firmware config for a `nice_nano_v2` + `lily58` split board, combining:

- The build plumbing, home-row-mod infrastructure, and OLED/battery setup
  from [`daer68/silakka54-zmk-config`](https://github.com/daer68/silakka54-zmk-config).
- The layout design from **[Kenkyo](https://github.com/argenkiwi/kenkyo)**:
  home/bottom-row mods, one-key chords, the `extend` (navigation/media) layer,
  and the `fumbol` (numbers/function-keys/symbols) layer.

## Layout

![keymap diagram](keymap-drawer/lily58.svg)

Regenerated automatically on every push by
[`.github/workflows/draw-keymap.yml`](.github/workflows/draw-keymap.yml)
(via [keymap-drawer](https://github.com/caksoylar/keymap-drawer)). To
regenerate it locally after editing the keymap: `./draw.sh`.

## What's different from both sources

- `extend` and `fumbol` are separate layers, each held on its own dedicated
  thumb key (not combined with Space, and not held on V/M as in Kenkyo).
- A new `fn` layer activates when `extend` and `fumbol` are held together
  (same tri-layer trick the old config used for `sys`). For now it only
  carries the old config's bluetooth profile controls.
- Kenkyo's one-shot modifier chords (space-anchored and multi-modifier) are
  intentionally not ported.
- Thumb row, left to right: (blank), Shift, Extend, Space | Backspace,
  Fumbol, Enter, (blank).

## Layers

- **default** — QWERTY with home/bottom-row mods (Alt/Gui/Shift/Ctrl on
  `A S D F` / `J K L ;`, Ctrl/AltGr on `Z X` / `. /`), plus one-key chords
  `W+E`→Esc, `I+O`→Backspace, `X+C`→Tab, `,+.`→Enter.
- **extend** — navigation (arrows, Home/End/PgUp/PgDn/Ins), plain modifier
  taps on the home row, media keys (mute/volume/play-pause).
- **fumbol** — `F1`–`F12`, numbers on the home row (still mod-tapped), and
  symbol/math chords (`S+D`→`-`, `D+F`→`+`, `J+K`→`/`, `K+L`→`*`, `J+L`→`.`).
- **fn** — bluetooth profile selection (`BT_SEL 0-4`) and a 3-second hold to
  clear the current profile's bond.

## Building

One-time toolchain setup (west, Python deps, Zephyr SDK), then:

```sh
west init -l config
west update
```

From then on, `./build.sh` builds both halves and drops the firmware into
`install/` (`./build.sh --pristine` for a clean reconfigure). Or push to
GitHub and let `.github/workflows/build.yml` build both halves as CI
artifacts instead.

## Credits

The `extend`/`fumbol` layer design and one-key chords are adapted from
**[Kenkyo](https://github.com/argenkiwi/kenkyo)**, a minimal 31-key layered
layout by [argenkiwi](https://github.com/argenkiwi). This repo only ports
that design onto different (split, `lily58`) hardware with different
thumb-key wiring and a new `fn` layer — all credit for the underlying layout
goes to the original project. Go check it out.

## License

MIT — see [LICENSE](LICENSE).
