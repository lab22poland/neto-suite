#!/bin/bash

# NETo Project Suite - Submodule Setup Script
# Run this script AFTER creating the GitHub repositories for netoman and netolib

echo "🚀 Setting up NETo Project Suite with submodules..."

# Configure git to always use 'main' as default branch
echo "⚙️  Configuring git to use 'main' as default branch..."
git config --global init.defaultBranch main

# Step 1: Push netoman to its remote repository
echo "📤 Pushing netoman to GitHub..."
cd netoman
git remote add origin https://github.com/lab22poland/netoman.git
git push -u origin main
cd ..

# Step 2: Push netolib to its remote repository  
echo "📤 Pushing netolib to GitHub..."
cd netolib
git remote add origin https://github.com/lab22poland/netolib.git
git push -u origin main
cd ..

# Step 3: Remove the local directories (they'll be replaced by submodules)
echo "🗑️  Removing local directories..."
rm -rf neto netoman netolib

# Step 4: Add repositories as submodules
echo "🔗 Adding submodules..."
git submodule add https://github.com/lab22poland/neto.git neto
git submodule add https://github.com/lab22poland/netoman.git netoman
git submodule add https://github.com/lab22poland/netolib.git netolib

# Step 5: Initialize and update submodules
echo "⬇️  Initializing submodules..."
git submodule update --init --recursive

# Step 6: Commit the main repository
echo "💾 Committing main repository..."
git add .
git commit -m "Initial commit: Add NETo project suite with submodules

- neto: SwiftUI application for iOS/iPadOS/macOS
- netoman: Documentation and manual repository
- netolib: Core networking library
"

echo "✅ Setup complete!"
echo ""
echo "Next steps:"
echo "1. Create remote repository for this main project"
echo "2. Push to remote: git remote add origin <your-main-repo-url>"
echo "3. Push to remote: git push -u origin main"
echo ""
echo "To clone this project elsewhere:"
echo "git clone --recursive <your-main-repo-url>" 