#!/bin/bash

# This script helps you create a GitHub repository and push your files to it

# Set your GitHub username
echo "Enter your GitHub username:"
read GITHUB_USERNAME

# Set repository name
echo "Enter repository name (default: domestic-violence-response-coach):"
read REPO_NAME
REPO_NAME=${REPO_NAME:-domestic-violence-response-coach}

# Set repository description
echo "Enter repository description (optional):"
read REPO_DESCRIPTION

# Initialize git repository
git init

# Add all files
git add .

# Commit files
git commit -m "Initial commit"

# Create GitHub repository using GitHub CLI (gh)
# Check if gh is installed
if command -v gh &> /dev/null; then
    echo "Creating GitHub repository using GitHub CLI..."
    if [ -z "$REPO_DESCRIPTION" ]; then
        gh repo create "$REPO_NAME" --public --source=. --push
    else
        gh repo create "$REPO_NAME" --description "$REPO_DESCRIPTION" --public --source=. --push
    fi
else
    echo "GitHub CLI (gh) not found. Please install it or create the repository manually."
    echo "After creating the repository, run these commands:"
    echo "git remote add origin https://github.com/$GITHUB_USERNAME/$REPO_NAME.git"
    echo "git branch -M main"
    echo "git push -u origin main"
fi

echo ""
echo "Next steps:"
echo "1. Upload your CloudFormation template to an S3 bucket"
echo "2. Make the template publicly accessible"
echo "3. Update the README.md file with your S3 bucket name"
echo "4. Push the updated README to GitHub"
