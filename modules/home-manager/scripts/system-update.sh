#!/usr/bin/env bash

# NixOS Update and Maintenance Script
# This script updates flake.lock, rebuilds the system, collects garbage, and commits changes
# Usage: update_system [hostname]

set -e # Exit on error

# Get hostname from argument or system hostname
FLAKE_HOST="${1:-$(hostname)}"

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

# Function to print colored output
print_status() {
    echo -e "${GREEN}==>${NC} $1"
}

print_error() {
    echo -e "${RED}Error:${NC} $1"
}

print_warning() {
    echo -e "${YELLOW}Warning:${NC} $1"
}

# Check if running in a flake directory
if [ ! -f "flake.nix" ]; then
    print_error "flake.nix not found in current directory"
    exit 1
fi

# Check if git repo
if [ ! -d ".git" ]; then
    print_warning "Not a git repository. Skipping git operations."
    SKIP_GIT=true
else
    SKIP_GIT=false
fi

print_status "Updating flake.lock..."
nix flake update

print_status "Rebuilding NixOS configuration for host: $FLAKE_HOST..."
sudo nixos-rebuild switch --flake ~/nixos#$FLAKE_HOST

print_status "Collecting garbage (older than 30 days)..."
sudo nix-collect-garbage --delete-older-than 30d

# Optimize nix store (optional, uncomment if desired)
# print_status "Optimizing nix store..."
# sudo nix-store --optimize

# Git operations
if [ "$SKIP_GIT" = false ]; then
    print_status "Staging flake.lock..."
    git add flake.lock

    # Check if there are changes to commit
    if git diff --cached --quiet; then
        print_warning "No changes to commit"
    else
        print_status "Committing changes..."
        COMMIT_MSG="chore: update \`flake.lock\` - $(date '+%Y-%m-%d')"
        git commit -m "$COMMIT_MSG"
        print_status "Committed: $COMMIT_MSG"
    fi
fi

print_status "Update complete!"
print_status "Run \`git push origin\` to sync changes."
