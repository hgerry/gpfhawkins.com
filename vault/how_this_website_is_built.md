# How this website is built

- Files are written in Obsidian, and edited locally. The website is an obsidian vault.
- Files are copied to a github repo
- Hosting is with Cloudflare
- Local build flow from the cmd line:
  
```
./build.sh
git add
git commit
git push 
```
- Changes to the repo are automatically picked up by cloudflare

---

Build.sh
```
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
```

---
style.css
```
body {
  margin: 4rem auto;
  max-width: 65ch;
  padding: 0 1.25rem;
  background: #161616;
  color: #E6E4E1;
  font-family: system-ui, -apple-system, BlinkMacSystemFont, "Segoe UI", sans-serif;
  font-size: 1rem;
  line-height: 1.65;
}

h1, h2, h3 {
  font-family: inherit;
  font-weight: 600;
  letter-spacing: -0.01em;
  color: #D8A1A6;
}

p { margin: 1.25rem 0; }
a { color: #D8A1A6; text-decoration: none; }
a:hover { color: #B8898D; }
/* Navigation links only */
p > a {
  margin-right: 1.25rem;
}

pre {
  background: #1E1E1E;
  padding: 1rem;
  overflow-x: auto;
}

img {
  display: block;
  margin: 2rem auto;
  max-width: 100%;
}
```