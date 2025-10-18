# Development Workflow

This document outlines the development workflow for the AI Cat vs Dog Voting App.

## 🌊 Git Flow Strategy

### Branch Types
- **`main`** - Production-ready code, auto-deploys to production
- **`develop`** - Integration branch for features, auto-deploys to staging
- **`feature/*`** - Individual feature development, auto-deploys to dev environment
- **`hotfix/*`** - Critical bug fixes for production
- **`release/*`** - Release preparation branches

### Branch Naming Convention
```
feature/tournament-bracket-ui
feature/signalr-integration
bugfix/voting-validation-issue
hotfix/critical-database-bug
```

## 🚀 Development Process

### 1. Starting a New Feature

```bash
# Start from latest main
git checkout main
git pull origin main

# Create feature branch
git checkout -b feature/your-feature-name

# Start development environment
docker-compose up -d
```

### 2. Development Loop

```bash
# Make changes to code
# Test locally with hot reload

# Frontend development
cd frontend && npm run dev

# Backend development  
cd backend && dotnet watch run

# Run tests
npm test                    # Frontend tests
dotnet test                # Backend tests
docker-compose -f docker-compose.test.yml up  # Integration tests
```

### 3. Pre-commit Checks

```bash
# Run linting
cd frontend && npm run lint
cd backend && dotnet format

# Run all tests
docker-compose -f docker-compose.test.yml up --abort-on-container-exit

# Build production images locally
docker-compose -f docker-compose.prod.yml build
```

### 4. Commit and Push

```bash
# Stage changes
git add .

# Commit with descriptive message
git commit -m "feat: add tournament bracket visualization component

- Created TournamentBracket component with SVG rendering
- Added responsive design for mobile devices  
- Integrated with tournament state management
- Added unit tests for bracket logic

Closes #123"

# Push to remote
git push origin feature/your-feature-name
```

### 5. Automated Deployment

Upon pushing to feature branch:
1. ✅ CI pipeline runs (tests, linting, security scans)
2. 🏗️ Docker images are built and pushed
3. 🚀 Auto-deployment to dev environment
4. 🔗 Deployment URL posted in PR comments

### 6. Create Pull Request

```bash
# Create PR using GitHub CLI
gh pr create --title "Add tournament bracket visualization" \
             --body "Implements tournament bracket UI component with responsive design" \
             --reviewer teammate1,teammate2
```

### 7. PR Review Process

**PR Requirements:**
- ✅ All CI checks pass
- ✅ Code review approved by 2+ reviewers
- ✅ Deployment to dev environment successful
- ✅ Manual testing completed
- 📝 Documentation updated if needed

### 8. Merge and Deploy

After PR approval:
1. **Squash and merge** to `main` branch
2. 🚀 Auto-deployment to production triggered
3. 🏷️ Auto-tagging with semantic version
4. 📊 Monitoring alerts activated
5. 🗑️ Feature branch auto-deleted

## 🧪 Testing Strategy

### Test Pyramid

```
        E2E Tests (Few)
       ↗             ↖
Integration Tests (Some)
    ↗                 ↖  
Unit Tests (Many)
```

### Local Testing

```bash
# Unit Tests
cd frontend && npm run test:watch
cd backend && dotnet watch test

# Integration Tests
docker-compose -f docker-compose.test.yml up

# E2E Tests
cd e2e-tests && npx playwright test

# Load Testing  
cd load-tests && k6 run tournament-load-test.js
```

### Automated Testing in CI

1. **Unit Tests** - Run on every commit
2. **Integration Tests** - Run on PR creation
3. **E2E Tests** - Run on deployment to staging
4. **Load Tests** - Run weekly on production
5. **Security Scans** - Run on every commit

## 🚀 Deployment Environments

### Development Environment
- **Trigger**: Push to feature branches
- **URL**: `https://catvdog-dev-{branch}.azurecontainerapps.io`
- **Database**: Shared dev database
- **Purpose**: Feature testing and development

### Staging Environment  
- **Trigger**: Push to `develop` branch
- **URL**: `https://catvdog-staging.azurecontainerapps.io`
- **Database**: Production-like data
- **Purpose**: Integration testing and stakeholder reviews

### Production Environment
- **Trigger**: Merge to `main` branch
- **URL**: `https://catvdog.azurecontainerapps.io`
- **Database**: Production database with backups
- **Purpose**: Live application for end users

## 🔄 CI/CD Pipeline Details

### Continuous Integration (CI)
```yaml
Trigger: Push to any branch
Steps:
  1. Checkout code
  2. Setup build environment
  3. Restore dependencies
  4. Run linting and formatting
  5. Run unit tests
  6. Run security scans
  7. Build Docker images
  8. Run integration tests
  9. Generate test coverage reports
  10. Publish artifacts
```

### Continuous Deployment (CD)
```yaml
Trigger: CI success + branch rules
Steps:
  1. Deploy infrastructure (if changed)
  2. Push images to container registry
  3. Update container apps
  4. Run smoke tests
  5. Update monitoring dashboards
  6. Send notifications
```

## 🐛 Troubleshooting Development Issues

### Common Problems

#### 1. Database Connection Issues
```bash
# Check if database is running
docker-compose ps db

# Reset database
docker-compose down db
docker volume rm demoapp_postgres_data
docker-compose up -d db

# Check connection
docker-compose exec db psql -U devuser -d votingapp -c "\dt"
```

#### 2. Port Conflicts
```bash
# Find process using port
lsof -i :3000
lsof -i :8080

# Kill process
kill -9 <PID>

# Or change ports in docker-compose.yml
```

#### 3. Hot Reload Not Working
```bash
# Frontend hot reload issues
cd frontend
rm -rf node_modules .vite
npm install
npm run dev

# Backend hot reload issues  
cd backend
dotnet clean
dotnet restore
dotnet watch run
```

#### 4. Docker Build Issues
```bash
# Clear Docker cache
docker system prune -a

# Rebuild without cache
docker-compose build --no-cache

# Check for file permission issues (Linux/Mac)
sudo chown -R $USER:$USER .
```

### Getting Help

1. **Check logs**: `docker-compose logs -f [service]`
2. **Review documentation** in `/docs` folder
3. **Search existing issues** in GitHub
4. **Ask team on Slack** #catvdog-dev channel
5. **Create GitHub issue** with reproducible steps

## 📊 Code Quality Standards

### Code Reviews
- **Security**: No hardcoded secrets, proper authentication
- **Performance**: Efficient queries, proper caching
- **Maintainability**: Clear naming, proper abstractions
- **Testing**: Adequate test coverage, edge cases covered
- **Documentation**: README updated, code comments where needed

### Definition of Done
- [ ] Feature implemented according to acceptance criteria
- [ ] Unit tests written and passing
- [ ] Integration tests updated if needed  
- [ ] Code reviewed and approved
- [ ] Documentation updated
- [ ] Deployed to dev environment and tested
- [ ] Performance impact assessed
- [ ] Security implications reviewed

## 🎯 Release Process

### Semantic Versioning
- **MAJOR** (1.0.0): Breaking changes
- **MINOR** (0.1.0): New features, backward compatible
- **PATCH** (0.0.1): Bug fixes, backward compatible

### Release Checklist
- [ ] All features in release scope completed
- [ ] All tests passing
- [ ] Performance benchmarks met
- [ ] Security review completed
- [ ] Documentation updated
- [ ] Deployment to staging successful
- [ ] Stakeholder sign-off received
- [ ] Production deployment scheduled
- [ ] Rollback plan prepared
- [ ] Monitoring alerts configured