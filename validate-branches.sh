#!/bin/bash

# NETo Project Suite - Branch Validation Script
# Validates that all repositories in the suite are using main branch and proper git configuration

echo "🔍 Validating NETo Project Suite Git Configuration..."
echo "================================================="

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

VALIDATION_PASSED=true

# Check global git configuration
echo -e "\n📋 Checking Global Git Configuration:"
DEFAULT_BRANCH=$(git config --global init.defaultBranch)
if [ "$DEFAULT_BRANCH" = "main" ]; then
    echo -e "  ✅ ${GREEN}Global default branch: main${NC}"
else
    echo -e "  ❌ ${RED}Global default branch: $DEFAULT_BRANCH (should be 'main')${NC}"
    echo -e "     Run: ${YELLOW}git config --global init.defaultBranch main${NC}"
    VALIDATION_PASSED=false
fi

# Function to check repository branch
check_repo_branch() {
    local repo_name=$1
    local repo_path=$2
    
    if [ -d "$repo_path" ]; then
        cd "$repo_path"
        local current_branch=$(git branch --show-current 2>/dev/null)
        local default_branch=$(git symbolic-ref refs/remotes/origin/HEAD 2>/dev/null | sed 's@^refs/remotes/origin/@@')
        
        if [ "$current_branch" = "main" ]; then
            echo -e "  ✅ ${GREEN}$repo_name: main${NC}"
        else
            echo -e "  ❌ ${RED}$repo_name: $current_branch (should be 'main')${NC}"
            echo -e "     Run: ${YELLOW}cd $repo_path && git branch -m $current_branch main${NC}"
            VALIDATION_PASSED=false
        fi
        cd - > /dev/null
    else
        echo -e "  ⚠️  ${YELLOW}$repo_name: Directory not found${NC}"
        VALIDATION_PASSED=false
    fi
}

# Check all repositories
echo -e "\n🌿 Checking Repository Branches:"
check_repo_branch "Main Repository" "."
check_repo_branch "neto" "./neto"
check_repo_branch "netoman" "./netoman"  
check_repo_branch "netolib" "./netolib"

# Check for any remaining master branches
echo -e "\n🔍 Scanning for any remaining 'master' branches:"
MASTER_BRANCHES=$(find . -name ".git" -type d -exec sh -c 'cd "$(dirname "{}")" && git branch 2>/dev/null | grep -q "master" && echo "$(pwd): $(git branch 2>/dev/null | grep master)"' \;)

if [ -z "$MASTER_BRANCHES" ]; then
    echo -e "  ✅ ${GREEN}No 'master' branches found${NC}"
else
    echo -e "  ❌ ${RED}Found 'master' branches:${NC}"
    echo "$MASTER_BRANCHES" | while read line; do
        echo -e "     ${YELLOW}$line${NC}"
    done
    VALIDATION_PASSED=false
fi

# Summary
echo -e "\n📊 Validation Summary:"
echo "====================="
if [ "$VALIDATION_PASSED" = true ]; then
    echo -e "✅ ${GREEN}All repositories follow the NETo git standards!${NC}"
    echo -e "   • All repositories use 'main' as default branch"
    echo -e "   • Global git configuration is correct"
    exit 0
else
    echo -e "❌ ${RED}Some repositories need attention${NC}"
    echo -e "   Please address the issues listed above."
    echo -e "   Run this script again after making corrections."
    exit 1
fi 