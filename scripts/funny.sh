#!/bin/sh

# List of phrases
phrases="Windows_sucks
Use_Linux
I_use_Gentoo_btw"

# Count the number of lines
count=0
for _ in $(echo "$phrases"); do
    count=$((count + 1))
done

# Generate a random number between 0 and count-1
rand=$(od -An -N2 -tu2 < /dev/urandom | tr -d ' ')
i=$(expr "$rand" % "$count")

# Select the i-th phrase
line=0
for phrase in $(echo "$phrases"); do
    if [ "$line" -eq "$i" ]; then
        echo "$phrase" | espeak-ng --stdout | aplay
        exit 0
    fi
    line=$((line + 1))
done
