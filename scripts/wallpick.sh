#!/bin/sh

WALLDIR="$HOME/Pictures/wallpaper"

# Catppuccin Macchiato colors
BG="#24273a"   # base
FG="#cad3f5"   # text
SB="#181926"   # mauve

FONT="Iosevka Term:size=11"

choice=$(find "$WALLDIR" -type f \( \
    -iname '*.jpg' -o -iname '*.jpeg' -o -iname '*.png' -o -iname '*.webp' \
\) | sort | dmenu -i -l 10 \
    -fn "$FONT" \
    -nb "$BG" -nf "$FG" \
    -sb "$SB" -sf "$FG" \
    -p "Wallpaper:")

[ -n "$choice" ] && feh --bg-fill "$choice"
