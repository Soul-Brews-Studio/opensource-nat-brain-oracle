#!/bin/bash
# /project incubate - Add existing repo to incubate tracking
# Usage: project-incubate.sh <url-or-path> [slug]
#
# Examples:
#   project-incubate.sh https://github.com/laris-co/00_mz_forwarder
#   project-incubate.sh ~/Code/github.com/laris-co/arthur
#   project-incubate.sh https://github.com/owner/repo my-slug

set -e

INPUT="$1"
CUSTOM_SLUG="$2"

if [[ -z "$INPUT" ]]; then
  echo "Usage: project-incubate.sh <url-or-path> [slug]"
  exit 1
fi

PSI_ROOT="/Users/nat/Code/github.com/laris-co/Nat-s-Agents"

# Resolve input to repo path
if [[ "$INPUT" == https://github.com/* ]]; then
  # URL: extract org/repo, clone via ghq if needed
  REPO_SLUG="${INPUT#https://github.com/}"
  REPO_PATH="$HOME/Code/github.com/$REPO_SLUG"

  if [[ ! -d "$REPO_PATH" ]]; then
    echo "📥 Cloning via ghq..."
    ghq get -u "$INPUT"
  fi
elif [[ -d "$INPUT" ]]; then
  # Direct path
  REPO_PATH="$INPUT"
  # Extract org/repo from path
  REPO_SLUG="${REPO_PATH#$HOME/Code/github.com/}"
else
  # Expand ~ if present
  EXPANDED="${INPUT/#\~/$HOME}"
  if [[ -d "$EXPANDED" ]]; then
    REPO_PATH="$EXPANDED"
    REPO_SLUG="${REPO_PATH#$HOME/Code/github.com/}"
  else
    echo "❌ Not found: $INPUT"
    exit 1
  fi
fi

# Extract org and name
ORG=$(dirname "$REPO_SLUG")
NAME=$(basename "$REPO_SLUG")
SLUG="${CUSTOM_SLUG:-$NAME}"

# Create symlink
INCUBATE_PATH="$PSI_ROOT/ψ/incubate/repo/github.com/$ORG"
SYMLINK="$INCUBATE_PATH/$NAME"

if [[ -L "$SYMLINK" ]]; then
  echo "⚠️  Already symlinked: $SYMLINK"
else
  echo "🔗 Creating symlink..."
  mkdir -p "$INCUBATE_PATH"
  ln -sf "$REPO_PATH" "$SYMLINK"
fi

# Register slug (if not already registered)
if ! grep -q "^$SLUG:" "$PSI_ROOT/ψ/memory/slugs.yaml" 2>/dev/null; then
  echo "📝 Registering slug: $SLUG"
  echo "$SLUG: $REPO_PATH" >> "$PSI_ROOT/ψ/memory/slugs.yaml"
else
  echo "📝 Slug already registered: $SLUG"
fi

# Summary
echo ""
echo "✅ Incubating: $ORG/$NAME"
echo "✅ Location: $REPO_PATH"
echo "✅ Symlink: ψ/incubate/repo/github.com/$ORG/$NAME"
echo "✅ Slug: $SLUG"
