#!/bin/sh

# Set your wallpaper directory
WALLDIR="$HOME/Pictures/wallpaper"
FONT="Iosevka Term:size=11"

# Set desired opacity (0-100)
OPACITY=85

# 1. Fetch current theme colors from xrdb
# We use 'sed' to remove the alpha prefix [100] if pywal added it previously
BG=$(xrdb -query | grep 'background:' | awk 'NR==1 {print $2}' | sed 's/\[.*\]//')
FG=$(xrdb -query | grep 'foreground:' | awk 'NR==1 {print $2}')
SEL=$(xrdb -query | grep 'color4:' | awk 'NR==1 {print $2}')

# 2. Select wallpaper using dmenu
choice=$(find "$WALLDIR" -type f \( \
    -iname '*.jpg' -o -iname '*.jpeg' -o -iname '*.png' -o -iname '*.webp' \
\) | sort | dmenu -i -l 10 \
    -fn "$FONT" \
    -nb "$BG" -nf "$FG" \
    -sb "$SEL" -sf "$BG" \
    -p "Select Wallpaper:")

# 3. Apply the new wallpaper with transparency
if [ -n "$choice" ]; then
    # '-a' sets the alpha/opacity for URxvt and other Xresources-compatible apps
    wal -i "$choice" -a "$OPACITY"
    
    # Merge the new colors
    xrdb -merge "$HOME/.cache/wal/colors.Xresources"
    
    killall st
    st
fi
