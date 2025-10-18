#!/bin/bash

echo "🔍 GitHub Token Diagnostic Tool"
echo "==============================="
echo ""

# Check if token is set
if [ -z "$GITHUB_TOKEN" ]; then
    echo "❌ GITHUB_TOKEN is not set"
    exit 1
fi

echo "✅ GITHUB_TOKEN is set"
echo ""

# Check basic authentication
echo "🔐 Testing authentication..."
USER=$(curl -s -H "Authorization: token $GITHUB_TOKEN" https://api.github.com/user | jq -r '.login')
if [ "$USER" != "null" ] && [ "$USER" != "" ]; then
    echo "✅ Authentication successful as: $USER"
else
    echo "❌ Authentication failed"
    exit 1
fi
echo ""

# Check token scopes
echo "🔑 Checking token scopes..."
SCOPES=$(curl -s -I -H "Authorization: token $GITHUB_TOKEN" https://api.github.com/user | grep -i "x-oauth-scopes:" | cut -d' ' -f2- | tr -d '\r\n')
echo "Token scopes: $SCOPES"

if [[ $SCOPES == *"repo"* ]]; then
    echo "✅ Token has 'repo' scope"
else
    echo "❌ Token missing 'repo' scope (needed for creating issues)"
fi
echo ""

# Check repository permissions
echo "🏠 Checking repository permissions..."
REPO_INFO=$(curl -s -H "Authorization: token $GITHUB_TOKEN" https://api.github.com/repos/pelithne/demoapp)
ADMIN=$(echo $REPO_INFO | jq -r '.permissions.admin')
PUSH=$(echo $REPO_INFO | jq -r '.permissions.push')

echo "Admin permission: $ADMIN"
echo "Push permission: $PUSH"
echo ""

# Try to create a test issue
echo "🧪 Testing issue creation..."
ISSUE_RESPONSE=$(curl -s -X POST \
  -H "Authorization: token $GITHUB_TOKEN" \
  -H "Accept: application/vnd.github.v3+json" \
  -H "Content-Type: application/json" \
  https://api.github.com/repos/pelithne/demoapp/issues \
  -d '{
    "title": "Test Issue - Delete Me",
    "body": "This is a test issue to verify API permissions. Please delete this issue."
  }')

ERROR_MESSAGE=$(echo $ISSUE_RESPONSE | jq -r '.message // empty')
if [ -n "$ERROR_MESSAGE" ]; then
    echo "❌ Failed to create test issue: $ERROR_MESSAGE"
    echo ""
    echo "💡 Possible solutions:"
    echo "   1. Token needs 'repo' scope for private repos or 'public_repo' for public repos"
    echo "   2. Check if repository has organization restrictions"
    echo "   3. Verify token hasn't expired"
    echo "   4. Try creating issues manually in the web interface"
else
    ISSUE_NUMBER=$(echo $ISSUE_RESPONSE | jq -r '.number')
    echo "✅ Test issue created successfully: #$ISSUE_NUMBER"
    echo "🗑️  Deleting test issue..."
    
    # Delete the test issue
    curl -s -X PATCH \
      -H "Authorization: token $GITHUB_TOKEN" \
      -H "Accept: application/vnd.github.v3+json" \
      https://api.github.com/repos/pelithne/demoapp/issues/$ISSUE_NUMBER \
      -d '{"state": "closed"}' > /dev/null
    
    echo "✅ Ready to create real issues!"
fi

echo ""
echo "🚀 Next steps:"
echo "   • If token works: Run ./scripts/create-all-issues.sh"
echo "   • If token fails: Use manual URLs from ./scripts/create-issues-urls.sh"
echo "   • Or create issues via GitHub web interface"