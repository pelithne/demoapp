#!/bin/bash

# Simple test to create the first GitHub issue
# This will help us verify authentication is working

echo "Testing GitHub CLI authentication..."

# Test basic auth
if ! gh auth status &>/dev/null; then
    echo "❌ GitHub CLI not authenticated. Please run: gh auth login"
    exit 1
fi

echo "✅ GitHub CLI authenticated successfully!"
echo "Creating first issue: Project Setup..."

# Create the first critical issue
gh issue create \
  --title "🏗️ Setup Project Structure and Development Environment" \
  --body "**Priority:** High | **Effort:** 3 days

## Objective
Setup the initial project structure for a full-stack voting application.

## Tasks
- [ ] Create React frontend with TypeScript and Vite
- [ ] Setup .NET 8 Web API backend  
- [ ] Configure Docker containers for local development
- [ ] Setup PostgreSQL database connection
- [ ] Create initial project documentation

## Acceptance Criteria
- Both frontend and backend run locally in containers
- Database connectivity established
- Development environment documented

## Files to Create
- \`frontend/\` directory with React + Vite setup
- \`backend/\` directory with .NET 8 Web API" \
  --assignee @me

if [ $? -eq 0 ]; then
    echo "✅ First issue created successfully!"
    echo "🔗 View at: https://github.com/pelithne/demoapp/issues"
    echo ""
    echo "To create all remaining issues, run: ./scripts/create-issues.sh"
else
    echo "❌ Failed to create issue. Check authentication and try again."
    exit 1
fi