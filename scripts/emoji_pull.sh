
#!/usr/bin/env bash
set -euo pipefail

OUT="$HOME/.config/nvim/icons.txt"
CACHE_DIR="$HOME/.cache/nvim-icons"
mkdir -p "$CACHE_DIR"
> "$OUT"  # clear output file

echo "📦 Generating icon repository at $OUT ..."

# ----------------------
# 1️⃣ Emojis
# ----------------------
EMOJI_JSON="$CACHE_DIR/emoji.json"

if [[ ! -f "$EMOJI_JSON" ]]; then
  echo "🌐 Downloading Emoji JSON..."
  curl -sL https://raw.githubusercontent.com/github/gemoji/master/db/emoji.json -o "$EMOJI_JSON" || true
fi

# Validate JSON
if ! jq empty "$EMOJI_JSON" &>/dev/null; then
  echo "⚠️ Emoji JSON invalid or fetch failed, using fallback..."
  cat <<EOF > "$EMOJI_JSON"
[
  {"emoji": "🔥"},
  {"emoji": "⚡"},
  {"emoji": "✅"},
  {"emoji": "☑"},
  {"emoji": "❌"}
]
EOF
fi

jq -r '.[].emoji' "$EMOJI_JSON" >> "$OUT"

# ----------------------
# 2️⃣ Nerd Fonts
# ----------------------
NERD_JSON="$CACHE_DIR/i_all.json"

if [[ ! -f "$NERD_JSON" ]]; then
  echo "🌐 Downloading Nerd Font JSON..."
  curl -sL https://raw.githubusercontent.com/ryanoasis/nerd-fonts/master/bin/scripts/lib/i_all.json -o "$NERD_JSON" || true
fi

if ! jq empty "$NERD_JSON" &>/dev/null; then
  echo "⚠️ Nerd Font JSON invalid or fetch failed, skipping..."
else
  jq -r '.[] | .char' "$NERD_JSON" >> "$OUT"
fi

# ----------------------
# 3️⃣ Deduplicate and sort
# ----------------------
sort -u "$OUT" -o "$OUT"

echo "✅ Done! Total $(wc -l < "$OUT") icons written."

