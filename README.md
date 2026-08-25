# kenkyo-zmk-config

A ZMK firmware config for a `nice_nano_v2` + `lily58` split board, combining:

- The build plumbing, home-row-mod infrastructure, and OLED/battery setup
  from [`daer68/silakka54-zmk-config`](https://github.com/daer68/silakka54-zmk-config).
- The layout design from [`daer68/kenkyo`](https://github.com/daer68/kenkyo):
  home/bottom-row mods, one-key chords, the `extend` (navigation/media) layer,
  and the `fumbol` (numbers/function-keys/symbols) layer.

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

```sh
west init -l config
west update
west build -b nice_nano_v2 -- -DSHIELD="lily58_left nice_view_adapter nice_view_battery"
west build -b nice_nano_v2 -- -DSHIELD="lily58_right nice_view_adapter nice_view_battery"
```

Or push to GitHub and let `.github/workflows/build.yml` build both halves.

## License

MIT — see [LICENSE](LICENSE).
