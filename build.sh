#!/usr/bin/env bash
set -euo pipefail

# Build all markdown in vault/ to .html in the current directory,
# then rewrite Obsidian-friendly links (href="*.md") to (href="*.html")
# while keeping the vault pristine.

for f in vault/*.md; do
  [ -f "$f" ] || exit 0

  out="$(basename "${f%.md}").html"

  pandoc "$f" -s --css style.css -o "$out"

  tmp="${out}.tmp"
  # Rewrite only href targets ending in .md (including anchors like .md#section)
  sed -E 's/(href="[^"]*)\.md/\1.html/g' "$out" > "$tmp"
  mv "$tmp" "$out"
done
