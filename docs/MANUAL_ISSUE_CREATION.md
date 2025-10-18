# Manual GitHub Issues Creation Guide

If the script doesn't work, you can manually create these issues by copying the content below into GitHub's web interface.

Go to: https://github.com/pelithne/demoapp/issues/new

## Issue 1: 🏗️ Setup Project Structure and Development Environment

**Title:** 🏗️ Setup Project Structure and Development Environment

**Body:**
```
## Objective
Setup the initial project structure for a full-stack voting application with modern tech stack.

## Tasks
- [ ] Create React frontend with TypeScript and Vite
- [ ] Setup .NET 8 Web API backend  
- [ ] Configure Docker containers for local development
- [ ] Setup PostgreSQL database connection
- [ ] Create initial project documentation
- [ ] Setup development scripts and commands

## Acceptance Criteria
- Both frontend and backend run locally in containers
- Database connectivity established
- Development environment documented
- Hot reload works for both frontend and backend

## Tech Stack
- Frontend: React + TypeScript + Vite
- Backend: .NET 8 Web API
- Database: PostgreSQL
- Containerization: Docker & Docker Compose

## Priority
High - This blocks all other development
```

---

## Issue 2: 🗄️ Database Design and Models

**Title:** 🗄️ Database Design and Models

**Body:**
```
## Objective
Design and implement the database schema for images, tournaments, votes, and leaderboards.

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
- Seed data populates sample images
- Repository pattern implemented for testability

## Priority
High - Required for all data operations
```

---

## Issue 3: 🎨 Frontend Core Components

**Title:** 🎨 Frontend Core Components

**Body:**
```
## Objective
Build the core React components for the voting interface.

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
- Mobile-friendly design
- Smooth animations and transitions

## Priority
High - Core user experience
```

---

## Issue 4: ⚙️ Backend API Development

**Title:** ⚙️ Backend API Development

**Body:**
```
## Objective
Develop REST API endpoints for tournament management and voting.

## Tasks
- [ ] Create tournament management endpoints
- [ ] Implement voting API with validation
- [ ] Add image management endpoints
- [ ] Build leaderboard calculation logic
- [ ] Add authentication middleware
- [ ] Implement rate limiting for votes

## API Endpoints
- GET /api/tournaments - List tournaments
- POST /api/tournaments - Create tournament
- GET /api/tournaments/{id}/bracket - Get bracket
- POST /api/votes - Submit vote
- GET /api/leaderboard - Get current standings

## Acceptance Criteria
- All API endpoints documented with Swagger
- Voting logic prevents cheating
- Tournament progression works correctly
- API is properly secured
- Rate limiting implemented

## Priority
High - Required for frontend functionality
```

---

## Issue 5: 🖼️ Static Image Management

**Title:** 🖼️ Static Image Management

**Body:**
```
## Objective
Create initial set of AI-generated images and image management system.

## Tasks
- [ ] Generate 10 high-quality cat and dog images
- [ ] Create image storage folder structure
- [ ] Implement image serving endpoints
- [ ] Add image metadata management
- [ ] Optimize image formats and sizes

## Image Requirements
- 5 cat images, 5 dog images
- High resolution (1024x1024)
- Consistent style and quality
- Diverse breeds and poses
- Optimized for web delivery

## Acceptance Criteria
- 10 diverse, high-quality images available
- Images load quickly in the UI
- Metadata includes categories and descriptions
- Images are properly optimized

## Priority
Medium - Can use placeholder images initially
```

---

## Issue 6: 🏅 Tournament Logic Implementation

**Title:** 🏅 Tournament Logic Implementation

**Body:**
```
## Objective
Implement the core tournament bracket and voting logic.

## Tasks
- [ ] Create tournament initialization logic
- [ ] Implement bracket progression algorithms
- [ ] Add vote validation and counting
- [ ] Build tournament state management
- [ ] Create winner determination logic
- [ ] Add tournament history tracking

## Tournament Flow
1. Initialize: 10 images → 5 matchups
2. Round 1: 5 matchups → 5 winners
3. Round 2: 2 matchups + 1 bye → 3 remaining
4. Semi-final: 1 matchup + 1 bye → 2 finalists
5. Final: 1 matchup → 1 champion

## Acceptance Criteria
- Tournament progresses correctly through rounds
- Votes are counted accurately
- Winners advance to next round
- Tournament history is preserved
- Edge cases handled (ties, insufficient votes)

## Priority
High - Core business logic
```

---

## Additional Issues 7-15

Continue with the remaining issues from the WORK_ITEMS.md file:
- Issue 7: Real-time Features with SignalR
- Issue 8: Azure Infrastructure with Bicep
- Issue 9: CI/CD Pipeline Setup
- Issue 10: Azure OpenAI Integration
- Issue 11: Authentication and Security
- Issue 12: Progressive Web App Features
- Issue 13: Monitoring and Analytics
- Issue 14: Testing Strategy Implementation
- Issue 15: UI/UX Polish and Accessibility

## Quick Creation Tips

1. **Copy the title** exactly as shown
2. **Paste the body content** into the description
3. **Add labels** if available: `priority:high`, `type:feature`, `type:epic`, etc.
4. **Assign to yourself** or team members
5. **Set milestone** if you have project milestones

## Bulk Creation Alternative

You can also use GitHub's API directly:
```bash
# After proper authentication
curl -X POST \
  -H "Authorization: token YOUR_TOKEN" \
  -H "Accept: application/vnd.github.v3+json" \
  https://api.github.com/repos/pelithne/demoapp/issues \
  -d '{"title":"Issue Title","body":"Issue Body"}'
```