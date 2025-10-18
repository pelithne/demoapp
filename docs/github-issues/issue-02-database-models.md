## 🗄️ Database Design and Models

**Priority:** High | **Effort:** 2 days

### Objective
Design and implement the database schema for images, tournaments, votes, and leaderboards.

### Tasks
- [ ] Design database schema (Images, Tournaments, Votes, Users)
- [ ] Create Entity Framework models and DbContext
- [ ] Implement database migrations
- [ ] Add seed data for initial images
- [ ] Create repository pattern for data access

### Database Schema Design

#### Tables
1. **Images**
   - Id, Name, FilePath, Category (Cat/Dog), CreatedAt, IsActive
   
2. **Tournaments** 
   - Id, Name, Status, StartDate, EndDate, CurrentRound, CreatedAt
   
3. **TournamentImages**
   - Id, TournamentId, ImageId, Position, IsEliminated
   
4. **Votes**
   - Id, TournamentId, Round, MatchupId, WinnerId, LoserId, VotedAt, UserId
   
5. **Users** (for future auth)
   - Id, Username, Email, CreatedAt

### Acceptance Criteria
- Database schema supports tournament voting
- EF models created with proper relationships
- Migration scripts work locally and in Azure
- Seed data populates sample images
- Repository pattern implemented for testability