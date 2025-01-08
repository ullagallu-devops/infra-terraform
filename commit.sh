#!/bin/bash

# Prompt for commit message and branch name
read -p "Enter commit message: " message
read -p "Enter branch name: " branch_name

# Add all changes
git add .

# Commit with the provided message
git commit -m "$message"

# Ask for confirmation before pushing
read -p "Are you sure you want to push to '$branch_name'? (y/n): " confirm

if [[ "$confirm" == "y" || "$confirm" == "Y" ]]; then
    git push origin "$branch_name"
    echo "✅ Changes have been successfully pushed to '$branch_name'."
else
    echo "❌ Push aborted by user."
fi
