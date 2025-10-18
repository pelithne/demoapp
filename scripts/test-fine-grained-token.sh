#!/bin/bash

echo "🔍 Testing Fine-Grained GitHub Token Permissions"
echo "================================================"
echo ""

# Test basic repo access
echo "1. Testing repository access..."
response=$(curl -s -H "Authorization: token $GITHUB_TOKEN" \
  -H "Accept: application/vnd.github.v3+json" \
  https://api.github.com/repos/pelithne/demoapp)

if echo "$response" | grep -q '"id"'; then
    echo "   ✅ Repository access: OK"
else
    echo "   ❌ Repository access: FAILED"
    echo "   Response: $response"
fi

# Test issues read access
echo ""
echo "2. Testing issues read access..."
response=$(curl -s -H "Authorization: token $GITHUB_TOKEN" \
  -H "Accept: application/vnd.github.v3+json" \
  https://api.github.com/repos/pelithne/demoapp/issues)

if echo "$response" | grep -q '\[\]' || echo "$response" | grep -q '"number"'; then
    echo "   ✅ Issues read access: OK"
else
    echo "   ❌ Issues read access: FAILED"
    echo "   Response: $response"
fi

# Test issues write access
echo ""
echo "3. Testing issues write access..."
response=$(curl -s -X POST \
  -H "Authorization: token $GITHUB_TOKEN" \
  -H "Accept: application/vnd.github.v3+json" \
  https://api.github.com/repos/pelithne/demoapp/issues \
  -d '{
    "title": "Test Issue - DELETE ME",
    "body": "This is a test issue to verify write permissions. Please delete after testing."
  }')

if echo "$response" | grep -q '"number"'; then
    issue_number=$(echo "$response" | grep -o '"number":[0-9]*' | cut -d':' -f2)
    echo "   ✅ Issues write access: OK (Created issue #$issue_number)"
    echo "   🗑️  You can delete the test issue at: https://github.com/pelithne/demoapp/issues/$issue_number"
else
    echo "   ❌ Issues write access: FAILED"
    echo "   Response: $response"
fi

echo ""
echo "📋 Fine-Grained Token Requirements:"
echo "   Go to: https://github.com/settings/personal-access-tokens/new"
echo "   Repository: pelithne/demoapp"
echo "   Permissions needed:"
echo "   - Issues: Read and Write"
echo "   - Metadata: Read"
echo "   - Pull requests: Read and Write (for future PRs)"
echo "   - Contents: Read and Write (for code)"