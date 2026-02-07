#!/bin/bash
# Quick deployment commands for GitHub Pages

echo "Durham Transportation Safety AI Audit - GitHub Deployment"
echo "=========================================================="
echo

# Step 1: Create repo on GitHub first (manual step)
echo "Step 1: Create GitHub repository"
echo "  Go to: https://github.com/new"
echo "  Name: durham-transport-safety-audit"
echo "  Visibility: Public"
echo "  Initialize: NONE"
echo
read -p "Press Enter after creating the repository..."
echo

# Step 2: Add remote
echo "Step 2: Adding GitHub remote..."
git remote add origin https://github.com/jonasneves/durham-transport-safety-audit.git 2>/dev/null || echo "  Remote already exists"
git remote -v
echo

# Step 3: Push to GitHub
echo "Step 3: Pushing to GitHub..."
read -p "Ready to push? Press Enter to continue..."
git push -u origin main
echo

# Step 4: Instructions for GitHub Pages
echo "Step 4: Enable GitHub Pages"
echo "  1. Go to: https://github.com/jonasneves/durham-transport-safety-audit/settings/pages"
echo "  2. Under 'Build and deployment':"
echo "     Source: GitHub Actions"
echo "  3. Click Save"
echo
echo "Step 5: Watch deployment"
echo "  Go to: https://github.com/jonasneves/durham-transport-safety-audit/actions"
echo "  Wait for green checkmark (~2-3 minutes)"
echo
echo "Step 6: Access your live site"
echo "  https://jonasneves.github.io/durham-transport-safety-audit/"
echo
echo "=========================================================="
echo "✓ Deployment initiated!"
echo
echo "Next steps:"
echo "  1. Enable GitHub Pages in Settings"
echo "  2. Wait for Actions to complete"
echo "  3. Visit your live site!"
