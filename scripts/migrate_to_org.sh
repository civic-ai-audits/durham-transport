#!/bin/bash
# Migration script for civic-ai-audits organization

set -e

echo "╔══════════════════════════════════════════════════════════════════════════╗"
echo "║                                                                          ║"
echo "║       MIGRATE TO CIVIC-AI-AUDITS ORGANIZATION                            ║"
echo "║                                                                          ║"
echo "╚══════════════════════════════════════════════════════════════════════════╝"
echo

# Check if we're in the right directory
if [ ! -f "README.md" ] || [ ! -d ".git" ]; then
    echo "❌ Error: Must run from project root directory"
    exit 1
fi

echo "Step 1: Updating configuration files..."
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"

# Update vite.config.js
echo "  Updating vite.config.js..."
sed -i.bak "s|/durham-transport-safety-audit/|/durham-transport/|g" frontend/vite.config.js

# Update README badges
echo "  Updating README.md badges..."
sed -i.bak "s|jonasneves/durham-transport-safety-audit|civic-ai-audits/durham-transport|g" README.md
sed -i.bak "s|jonasneves.github.io/durham-transport-safety-audit|civic-ai-audits.github.io/durham-transport|g" README.md

# Update all markdown files
echo "  Updating documentation..."
find . -name "*.md" -type f -exec sed -i.bak \
  -e "s|jonasneves/durham-transport-safety-audit|civic-ai-audits/durham-transport|g" \
  -e "s|jonasneves.github.io/durham-transport-safety-audit|civic-ai-audits.github.io/durham-transport|g" {} \;

# Clean up backup files
find . -name "*.bak" -type f -delete

echo "  ✓ Configuration files updated"
echo

echo "Step 2: Updating git remote..."
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"

# Update remote URL
git remote set-url origin https://github.com/civic-ai-audits/durham-transport.git
echo "  ✓ Remote URL updated to: civic-ai-audits/durham-transport"
echo

echo "Step 3: Committing changes..."
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"

git add .
git commit -m "Migrate to civic-ai-audits organization

- Update all URLs from personal to organization
- Update vite config for new base path
- Update README badges
- Update documentation links
- New URL: civic-ai-audits.github.io/durham-transport"

echo "  ✓ Changes committed"
echo

echo "Step 4: Pushing to new organization..."
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"

git push

echo "  ✓ Changes pushed"
echo

echo "╔══════════════════════════════════════════════════════════════════════════╗"
echo "║                                                                          ║"
echo "║                   ✅ MIGRATION COMPLETE! ✅                              ║"
echo "║                                                                          ║"
echo "╚══════════════════════════════════════════════════════════════════════════╝"
echo
echo "New URLs:"
echo "  Repository: https://github.com/civic-ai-audits/durham-transport"
echo "  Live Demo:  https://civic-ai-audits.github.io/durham-transport/"
echo
echo "Next steps:"
echo "  1. Enable GitHub Pages:"
echo "     https://github.com/civic-ai-audits/durham-transport/settings/pages"
echo "  2. Wait for deployment (~2-3 minutes)"
echo "  3. Visit live site: https://civic-ai-audits.github.io/durham-transport/"
echo
echo "✓ All done!"
