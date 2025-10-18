#!/bin/bash

# GitHub Issue Creation via Web Interface
# Since API access is restricted, this script generates URLs to create issues quickly

echo "🚀 GitHub Issue Creation Helper"
echo "================================"
echo ""
echo "The GitHub token has read-only access. Here are direct links to create each issue:"
echo ""

# Base URL for creating issues
BASE_URL="https://github.com/pelithne/demoapp/issues/new"

# Issue 1: Project Setup
echo "1. 🏗️ Project Setup:"
echo "   ${BASE_URL}?title=🏗️%20Setup%20Project%20Structure%20and%20Development%20Environment&body=**Priority:%20High**%0A%0A##%20Objective%0ASetup%20the%20initial%20project%20structure%20for%20a%20full-stack%20voting%20application.%0A%0A##%20Tasks%0A-%20[]%20Create%20React%20frontend%20with%20TypeScript%20and%20Vite%0A-%20[]%20Setup%20.NET%208%20Web%20API%20backend%0A-%20[]%20Configure%20Docker%20containers%20for%20local%20development%0A-%20[]%20Setup%20PostgreSQL%20database%20connection"
echo ""

# Issue 2: Database Design
echo "2. 🗄️ Database Design:"
echo "   ${BASE_URL}?title=🗄️%20Database%20Design%20and%20Models&body=**Priority:%20High**%0A%0A##%20Objective%0ADesign%20and%20implement%20database%20schema%20for%20images,%20tournaments,%20votes,%20and%20leaderboards.%0A%0A##%20Tasks%0A-%20[]%20Design%20database%20schema%0A-%20[]%20Create%20Entity%20Framework%20models%0A-%20[]%20Implement%20database%20migrations%0A-%20[]%20Add%20seed%20data"
echo ""

# Issue 3: Frontend Components
echo "3. 🎨 Frontend Components:"
echo "   ${BASE_URL}?title=🎨%20Frontend%20Core%20Components&body=**Priority:%20High**%0A%0A##%20Objective%0ABuild%20core%20React%20components%20for%20the%20voting%20interface.%0A%0A##%20Tasks%0A-%20[]%20Create%20tournament%20bracket%20visualization%0A-%20[]%20Build%20voting%20interface%0A-%20[]%20Implement%20image%20display%20components%0A-%20[]%20Add%20real-time%20leaderboard"
echo ""

# Issue 4: Backend API
echo "4. ⚙️ Backend API:"
echo "   ${BASE_URL}?title=⚙️%20Backend%20API%20Development&body=**Priority:%20High**%0A%0A##%20Objective%0ADevelop%20REST%20API%20endpoints%20for%20tournament%20management%20and%20voting.%0A%0A##%20Tasks%0A-%20[]%20Create%20tournament%20management%20endpoints%0A-%20[]%20Implement%20voting%20API%0A-%20[]%20Add%20authentication%20middleware%0A-%20[]%20Implement%20rate%20limiting"
echo ""

# Issue 5: Image Management
echo "5. 🖼️ Image Management:"
echo "   ${BASE_URL}?title=🖼️%20Static%20Image%20Management&body=**Priority:%20Medium**%0A%0A##%20Objective%0ACreate%20initial%20set%20of%20AI-generated%20images%20and%20management%20system.%0A%0A##%20Tasks%0A-%20[]%20Generate%2010%20high-quality%20images%0A-%20[]%20Create%20image%20storage%20structure%0A-%20[]%20Implement%20image%20serving%20endpoints%0A-%20[]%20Optimize%20image%20formats"
echo ""

echo "💡 Quick Tips:"
echo "   • Click any URL above to pre-fill the issue form"
echo "   • Modify the description as needed"
echo "   • Add labels: priority:high, type:feature, etc."
echo "   • Assign to yourself or team members"
echo ""
echo "📋 All 15 detailed work items are in: docs/WORK_ITEMS.md"
echo "📖 Manual creation guide: docs/MANUAL_ISSUE_CREATION.md"