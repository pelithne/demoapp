#!/bin/bash

# Script to create all GitHub issues for the AI Cat vs Dog Voting App (without labels)
# Run this script after ensuring you're authenticated with GitHub CLI

echo "Creating GitHub issues for AI Cat vs Dog Voting App..."

# Issue 2: Database Design (Issue 1 already exists)
gh issue create \
  --title "🗄️ Database Design and Models" \
  --body "**Priority:** High | **Effort:** 2 days

## Objective
Design and implement database schema for images, tournaments, votes, and leaderboards.

## Tasks
- [ ] Design database schema (Images, Tournaments, Votes, Users)
- [ ] Create Entity Framework models and DbContext
- [ ] Implement database migrations
- [ ] Add seed data for initial images
- [ ] Create repository pattern for data access

## Database Schema Design
1. **Images**: Id, Name, FilePath, Category (Cat/Dog), CreatedAt, IsActive
2. **Tournaments**: Id, Name, Status, StartDate, EndDate, CurrentRound, CreatedAt
3. **TournamentImages**: Id, TournamentId, ImageId, Position, IsEliminated
4. **Votes**: Id, TournamentId, Round, MatchupId, WinnerId, LoserId, VotedAt, UserId
5. **Users**: Id, Username, Email, CreatedAt

## Acceptance Criteria
- Database schema supports tournament voting
- EF models created with proper relationships
- Migration scripts work locally and in Azure
- Seed data populates sample images"

# Issue 3: Frontend Core Components
gh issue create \
  --title "🎨 Frontend Core Components" \
  --body "**Priority:** High | **Effort:** 4 days

## Objective
Build core React components for the voting interface.

## Tasks
- [ ] Create tournament bracket visualization
- [ ] Build voting interface for head-to-head matchups
- [ ] Implement image display components
- [ ] Add real-time leaderboard component
- [ ] Create responsive design with Tailwind CSS
- [ ] Add loading states and error handling

## Acceptance Criteria
- Tournament bracket displays correctly
- Voting interface is intuitive and responsive
- Leaderboard updates in real-time
- Mobile-friendly design"

# Issue 4: Backend API Development
gh issue create \
  --title "⚙️ Backend API Development" \
  --body "**Priority:** High | **Effort:** 3 days

## Objective
Develop REST API endpoints for tournament management and voting.

## Tasks
- [ ] Create tournament management endpoints
- [ ] Implement voting API with validation
- [ ] Add image management endpoints
- [ ] Build leaderboard calculation logic
- [ ] Add authentication middleware
- [ ] Implement rate limiting for votes

## Acceptance Criteria
- All API endpoints documented with Swagger
- Voting logic prevents cheating
- Tournament progression works correctly
- API is properly secured"

# Issue 5: Static Image Management
gh issue create \
  --title "🖼️ Static Image Management" \
  --body "**Priority:** Medium | **Effort:** 1 day

## Objective
Create initial set of AI-generated images and image management system.

## Tasks
- [ ] Generate 10 high-quality cat and dog images
- [ ] Create image storage folder structure
- [ ] Implement image serving endpoints
- [ ] Add image metadata management
- [ ] Optimize image formats and sizes

## Acceptance Criteria
- 10 diverse, high-quality images available
- Images load quickly in the UI
- Metadata includes categories and descriptions"

# Issue 6: Tournament Logic Implementation
gh issue create \
  --title "🏅 Tournament Logic Implementation" \
  --body "**Priority:** High | **Effort:** 3 days

## Objective
Implement core tournament bracket and voting logic.

## Tasks
- [ ] Create tournament initialization logic
- [ ] Implement bracket progression algorithms
- [ ] Add vote validation and counting
- [ ] Build tournament state management
- [ ] Create winner determination logic
- [ ] Add tournament history tracking

## Acceptance Criteria
- Tournament progresses correctly through rounds
- Votes are counted accurately
- Winners advance to next round
- Tournament history is preserved"

# Issue 7: Real-time Features with SignalR
gh issue create \
  --title "📊 Real-time Features with SignalR" \
  --body "**Priority:** Medium | **Effort:** 2 days

## Objective
Add real-time updates for voting and leaderboards.

## Tasks
- [ ] Setup SignalR hub in backend
- [ ] Implement real-time vote updates
- [ ] Add live leaderboard updates
- [ ] Create connection management
- [ ] Add offline/online status handling

## Acceptance Criteria
- Votes update in real-time across all clients
- Leaderboard reflects current standings
- Connection issues handled gracefully"

# Issue 8: Azure Infrastructure with Bicep
gh issue create \
  --title "🏗️ Azure Infrastructure with Bicep" \
  --body "**Priority:** High | **Effort:** 2 days

## Objective
Create Infrastructure as Code for Azure deployment.

## Tasks
- [ ] Create Bicep templates for all Azure resources
- [ ] Setup Azure Container Apps environment
- [ ] Configure PostgreSQL Flexible Server
- [ ] Create Azure Blob Storage for images
- [ ] Setup Application Insights for monitoring
- [ ] Configure managed identities and RBAC

## Acceptance Criteria
- All infrastructure deployable via Bicep
- Resources follow Azure best practices
- Managed identities used for authentication
- Cost-optimized for low usage"

# Issue 9: CI/CD Pipeline Setup
gh issue create \
  --title "🚀 CI/CD Pipeline Setup" \
  --body "**Priority:** High | **Effort:** 2 days

## Objective
Create GitHub Actions workflows for CI/CD.

## Tasks
- [ ] Create CI pipeline for code quality checks
- [ ] Setup containerization and image building
- [ ] Create deployment pipeline for feature branches
- [ ] Add automated testing integration
- [ ] Setup production deployment pipeline
- [ ] Add infrastructure deployment automation

## Acceptance Criteria
- CI runs on every push/PR
- Feature branches auto-deploy to test environment
- Main branch deploys to production
- Infrastructure changes deployed automatically"

# Issue 10: Azure OpenAI Integration
gh issue create \
  --title "🤖 Azure OpenAI Integration" \
  --body "**Priority:** Medium | **Effort:** 3 days

## Objective
Replace static images with real-time AI image generation.

## Tasks
- [ ] Setup Azure OpenAI service connection
- [ ] Implement DALL-E image generation API
- [ ] Create image generation background service
- [ ] Add image caching and storage to Blob Storage
- [ ] Implement prompt engineering for consistent quality
- [ ] Add generation queue and rate limiting

## Acceptance Criteria
- Images generated on-demand via Azure OpenAI
- Generated images stored in Blob Storage
- Generation respects rate limits and costs
- Image quality is consistent"

echo ""
echo "✅ All core issues created successfully!"
echo "🔗 View them at: https://github.com/pelithne/demoapp/issues"
echo ""
echo "💡 Next steps:"
echo "   1. Start with Issue #2 (Project Setup)"
echo "   2. Create feature branch: git checkout -b feature/project-setup"
echo "   3. Follow development workflow in docs/DEVELOPMENT_WORKFLOW.md"