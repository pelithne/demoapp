# 🐱🐶 AI Cat vs Dog Voting App

A modern, full-stack web application featuring tournament-style voting between AI-generated cat and dog images. Built with React, .NET 8, PostgreSQL, and deployed on Azure Container Apps.

## 🏆 Features

- **Tournament Bracket System**: Images compete in elimination rounds
- **Real-time Voting**: Live updates with SignalR
- **AI Image Generation**: Azure OpenAI DALL-E integration
- **Leaderboards**: Track winners and voting statistics  
- **Mobile Responsive**: Works great on all devices
- **Cloud Native**: Runs on Azure Container Apps with auto-scaling

## 🏗️ Architecture

```
┌─────────────────┐    ┌─────────────────┐    ┌─────────────────┐
│   React Frontend │────│   .NET 8 API    │────│   PostgreSQL    │
│   (TypeScript)   │    │   (SignalR)     │    │   (Flexible)    │
└─────────────────┘    └─────────────────┘    └─────────────────┘
         │                       │                       │
         └───────────────────────┼───────────────────────┘
                                 │
                    ┌─────────────────┐
                    │  Azure Blob     │
                    │  Storage        │
                    └─────────────────┘
```

## 🚀 Quick Start

### Prerequisites

- [Docker](https://docs.docker.com/get-docker/) and Docker Compose
- [.NET 8 SDK](https://dotnet.microsoft.com/download) (for development)
- [Node.js 20+](https://nodejs.org/) (for development)
- [Azure CLI](https://docs.microsoft.com/cli/azure/install-azure-cli) (for deployment)

### Local Development

1. **Clone the repository**
   ```bash
   git clone https://github.com/pelithne/demoapp.git
   cd demoapp
   ```

2. **Create environment file**
   ```bash
   cp .env.example .env
   # Edit .env with your preferences
   ```

3. **Start all services**
   ```bash
   docker-compose up -d
   ```

4. **Access the application**
   - Frontend: http://localhost:3000
   - Backend API: http://localhost:8080
   - API Documentation: http://localhost:8080/swagger

### Development Workflow

#### Working on Frontend
```bash
cd frontend
npm install
npm run dev
```

#### Working on Backend
```bash
cd backend
dotnet restore
dotnet run
```

#### Database Migrations
```bash
cd backend
dotnet ef migrations add YourMigrationName
dotnet ef database update
```

## 🧪 Testing

### Run All Tests
```bash
docker-compose -f docker-compose.test.yml up --abort-on-container-exit
```

### Frontend Tests Only
```bash
cd frontend
npm run test
npm run test:e2e
```

### Backend Tests Only
```bash
cd backend
dotnet test
```

## 🌩️ Azure Deployment

### Prerequisites
- Azure subscription
- Azure CLI logged in: `az login`
- Resource group created or permissions to create one

### Deploy Infrastructure
```bash
# Set environment variables
export DB_ADMIN_PASSWORD="YourSecurePassword123!"

# Deploy using Bicep
az deployment group create \
  --resource-group rg-catvdog-dev \
  --template-file infra/main.bicep \
  --parameters infra/main.bicepparam
```

### Deploy Application
The CI/CD pipeline automatically deploys when you push to `main` branch, or you can deploy manually:

```bash
# Build and push images
az acr build --registry your-registry --image backend:latest --file backend/Dockerfile backend/
az acr build --registry your-registry --image frontend:latest --file frontend/Dockerfile frontend/

# Update container apps
az containerapp update --name your-backend-app --resource-group your-rg --image your-registry.azurecr.io/backend:latest
az containerapp update --name your-frontend-app --resource-group your-rg --image your-registry.azurecr.io/frontend:latest
```

## 🔧 Configuration

### Environment Variables

#### Frontend (.env)
```bash
VITE_API_BASE_URL=http://localhost:8080
VITE_WS_URL=ws://localhost:8080/votehub
VITE_ENABLE_ANALYTICS=false
```

#### Backend (appsettings.json)
```json
{
  "ConnectionStrings": {
    "DefaultConnection": "Host=localhost;Database=votingapp;Username=devuser;Password=DevPassword123!"
  },
  "AzureStorage": {
    "AccountName": "your-storage-account",
    "ContainerName": "images"
  },
  "AzureOpenAI": {
    "Endpoint": "https://your-openai.openai.azure.com/",
    "ApiKey": "your-api-key"
  }
}
```

## 📁 Project Structure

```
demoapp/
├── frontend/                 # React TypeScript app
│   ├── src/
│   │   ├── components/       # React components
│   │   ├── hooks/           # Custom hooks
│   │   ├── services/        # API services
│   │   └── types/           # TypeScript types
│   ├── public/              # Static assets
│   └── Dockerfile
├── backend/                 # .NET 8 Web API
│   ├── Controllers/         # API controllers
│   ├── Models/             # Data models
│   ├── Services/           # Business logic
│   ├── Hubs/               # SignalR hubs
│   └── Dockerfile
├── infra/                  # Infrastructure as Code
│   ├── main.bicep          # Main Bicep template
│   └── main.bicepparam     # Parameters file
├── .github/workflows/      # CI/CD pipelines
├── docs/                   # Documentation
└── docker-compose.yml      # Local development
```

## 🤝 Contributing

1. **Create a feature branch**
   ```bash
   git checkout -b feature/your-feature-name
   ```

2. **Make changes and test locally**
   ```bash
   docker-compose up -d
   # Make your changes
   npm test  # or dotnet test
   ```

3. **Push and create PR**
   ```bash
   git push origin feature/your-feature-name
   # Create PR in GitHub
   ```

4. **Deployment Flow**
   - Push to feature branch → Auto-deploy to dev environment
   - Merge PR to main → Auto-deploy to production

## 🐛 Troubleshooting

### Common Issues

#### Database Connection Issues
```bash
# Reset database
docker-compose down -v
docker-compose up -d db
```

#### Port Conflicts
```bash
# Check what's using port 3000/8080
lsof -i :3000
lsof -i :8080
```

#### Container Build Issues
```bash
# Clean Docker cache
docker system prune -a
docker-compose build --no-cache
```

### Logs
```bash
# View all logs
docker-compose logs -f

# View specific service logs
docker-compose logs -f backend
docker-compose logs -f frontend
```

## 📊 Monitoring

- **Application Insights**: Monitor performance and errors
- **Azure Monitor**: Infrastructure metrics
- **Log Analytics**: Centralized logging

Access monitoring dashboards in Azure Portal under your resource group.

## 🔐 Security

- **Authentication**: Azure AD B2C integration
- **Authorization**: Role-based access control
- **Data Protection**: Encrypted connections and data at rest
- **Rate Limiting**: Prevents voting abuse
- **CORS**: Configured for security

## 📈 Performance

- **Auto-scaling**: Container Apps scale based on demand
- **Caching**: Redis for frequently accessed data
- **CDN**: Static assets served via Azure CDN
- **Database**: Optimized queries and indexes

## 📝 License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## 🙏 Acknowledgments

- Azure Container Apps team for the excellent platform
- OpenAI for DALL-E integration
- The open-source community for the amazing tools
