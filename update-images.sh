#!/bin/bash
# Scans the images/ folder and writes images.js so the slideshow finds your photos.
# Run this any time you add or remove photos:  ./update-images.sh
cd "$(dirname "$0")"
{
  echo "window.SLIDESHOW_IMAGES = ["
  find images -maxdepth 1 -type f \( -iname '*.jpg' -o -iname '*.jpeg' -o -iname '*.png' -o -iname '*.gif' -o -iname '*.webp' -o -iname '*.avif' \) | sort | while read -r f; do
    printf '  "%s",\n' "$f"
  done
  echo "];"
} > images.js
count=$(grep -c '^  "' images.js || true)
echo "✅ images.js updated with $count photo(s)."
