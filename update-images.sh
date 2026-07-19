#!/bin/bash
# Scans the images/ folder and writes images.js so the slideshow finds your photos.
# Run this any time you add or remove photos:  ./update-images.sh
cd "$(dirname "$0")"
all=$(find images -maxdepth 1 -type f \( -iname '*.jpg' -o -iname '*.jpeg' -o -iname '*.png' -o -iname '*.gif' -o -iname '*.webp' -o -iname '*.avif' \) | sort)
{
  echo "window.SLIDESHOW_IMAGES = ["
  # 1.* always shows first, then everything else alphabetically
  { echo "$all" | grep '^images/1\.' ; echo "$all" | grep -v '^images/1\.' ; } | while read -r f; do
    [ -n "$f" ] && printf '  "%s",\n' "$f"
  done
  echo "];"
} > images.js
count=$(grep -c '^  "' images.js || true)
echo "✅ images.js updated with $count photo(s)."
