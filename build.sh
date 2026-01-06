#!/bin/sh
# Minimal Markdown → HTML (requires pandoc)

for f in vault/*.md; do
  [ -f "$f" ] || exit 0
  pandoc "$f" -s --css style.css -o "$(basename "${f%.md}").html"
done
