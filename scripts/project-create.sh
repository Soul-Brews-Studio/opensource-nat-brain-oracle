#!/bin/bash
# /project create - Create new GitHub repo + ghq + symlink
# Usage: project-create.sh <name> [--public]

set -e

NAME="$1"
VISIBILITY="--private"

if [[ "$2" == "--public" ]]; then
  VISIBILITY="--public"
fi

if [[ -z "$NAME" ]]; then
  echo "Usage: project-create.sh <name> [--public]"
  exit 1
fi

ORG="laris-co"
REPO_PATH="$HOME/Code/github.com/$ORG/$NAME"
PSI_ROOT="/Users/nat/Code/github.com/laris-co/Nat-s-Agents"
INCUBATE_PATH="$PSI_ROOT/ψ/incubate/repo/github.com/$ORG"

echo "🚀 Creating $ORG/$NAME..."

# 1. Create GitHub repo
echo "📦 Creating GitHub repo..."
gh repo create "$ORG/$NAME" $VISIBILITY --description "$NAME project"

# 2. Clone via ghq
echo "📥 Cloning via ghq..."
ghq get "$ORG/$NAME"

# 3. Create symlink to ψ/incubate/
echo "🔗 Creating symlink..."
mkdir -p "$INCUBATE_PATH"
ln -sf "$REPO_PATH" "$INCUBATE_PATH/$NAME"

# 4. Register slug
echo "📝 Registering slug..."
echo "$NAME: $REPO_PATH" >> "$PSI_ROOT/ψ/memory/slugs.yaml"

# 5. Summary
echo ""
echo "✅ Created: $ORG/$NAME"
echo "✅ Location: $REPO_PATH"
echo "✅ Symlink: ψ/incubate/repo/github.com/$ORG/$NAME"
echo "✅ Slug: $NAME"
echo ""
echo "Next: git -C $REPO_PATH add -A && git -C $REPO_PATH commit -m 'Initial commit'"
