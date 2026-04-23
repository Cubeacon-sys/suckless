#!/bin/sh

WALLDIR="$HOME/Pictures/wallpaper"
FONT="KurisuFont:size=11"

OPACITY=85

BG=$(xrdb -query | grep 'background:' | awk 'NR==1 {print $2}' | sed 's/\[.*\]//')
FG=$(xrdb -query | grep 'foreground:' | awk 'NR==1 {print $2}')
SEL=$(xrdb -query | grep 'color4:' | awk 'NR==1 {print $2}')

choice=$(find "$WALLDIR" -type f \( \
    -iname '*.jpg' -o -iname '*.jpeg' -o -iname '*.png' -o -iname '*.webp' \
\) | sort | dmenu -i -l 10 \
    -fn "$FONT" \
    -nb "$BG" -nf "$FG" \
    -sb "$SEL" -sf "$BG" \
    -p "Select Wallpaper:")

if [ -n "$choice" ]; then
    # Generate colors and set wallpaper (-a for transparency)
    wal -i "$choice" -a "$OPACITY"
    
    # Update Xresources (for future terminals and dwm reload)
    xrdb -merge "$HOME/.cache/wal/colors.Xresources"
    
fi
