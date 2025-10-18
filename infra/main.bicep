// Main Bicep template for AI Cat vs Dog Voting App
// This template creates all necessary Azure resources for the application

@description('Environment name (e.g., dev, staging, prod)')
param environment string = 'dev'

@description('Application name prefix')
param appName string = 'catvdog'

@description('Azure region for all resources')
param location string = resourceGroup().location

@description('Container registry login server (optional, for existing ACR)')
param containerRegistryLoginServer string = ''

@secure()
@description('Database administrator password')
param dbAdminPassword string

// Variables for consistent naming
var uniqueSuffix = substring(uniqueString(resourceGroup().id), 0, 6)
var fullAppName = '${appName}-${environment}-${uniqueSuffix}'

// Log Analytics Workspace for monitoring
resource logAnalytics 'Microsoft.OperationalInsights/workspaces@2023-09-01' = {
  name: '${fullAppName}-logs'
  location: location
  properties: {
    sku: {
      name: 'PerGB2018'
    }
    retentionInDays: 30
  }
}

// Application Insights for telemetry
resource appInsights 'Microsoft.Insights/components@2020-02-02' = {
  name: '${fullAppName}-insights'
  location: location
  kind: 'web'
  properties: {
    Application_Type: 'web'
    WorkspaceResourceId: logAnalytics.id
  }
}

// Container Apps Environment
resource containerAppsEnvironment 'Microsoft.App/managedEnvironments@2024-03-01' = {
  name: '${fullAppName}-env'
  location: location
  properties: {
    appLogsConfiguration: {
      destination: 'log-analytics'
      logAnalyticsConfiguration: {
        customerId: logAnalytics.properties.customerId
        sharedKey: logAnalytics.listKeys().primarySharedKey
      }
    }
  }
}

// PostgreSQL Flexible Server (cost-effective, scales to zero when idle)
resource postgresqlServer 'Microsoft.DBforPostgreSQL/flexibleServers@2023-12-01-preview' = {
  name: '${fullAppName}-db'
  location: location
  sku: {
    name: 'Standard_B1ms' // Burstable tier - cost effective
    tier: 'Burstable'
  }
  properties: {
    version: '15'
    administratorLogin: 'dbadmin'
    administratorLoginPassword: dbAdminPassword
    storage: {
      storageSizeGB: 32 // Minimum size
      autoGrow: 'Enabled'
    }
    backup: {
      backupRetentionDays: 7
      geoRedundantBackup: 'Disabled' // Cost optimization
    }
    highAvailability: {
      mode: 'Disabled' // Cost optimization for dev/test
    }
  }
}

// PostgreSQL Database
resource postgresqlDatabase 'Microsoft.DBforPostgreSQL/flexibleServers/databases@2023-12-01-preview' = {
  parent: postgresqlServer
  name: 'votingapp'
}

// Allow Azure services to connect to PostgreSQL
resource postgresqlFirewallRule 'Microsoft.DBforPostgreSQL/flexibleServers/firewallRules@2023-12-01-preview' = {
  parent: postgresqlServer
  name: 'AllowAzureServices'
  properties: {
    startIpAddress: '0.0.0.0'
    endIpAddress: '0.0.0.0'
  }
}

// Storage Account for images and static files
resource storageAccount 'Microsoft.Storage/storageAccounts@2023-05-01' = {
  name: replace('${fullAppName}storage', '-', '') // Storage names can't have dashes
  location: location
  sku: {
    name: 'Standard_LRS' // Cost-effective for development
  }
  kind: 'StorageV2'
  properties: {
    accessTier: 'Hot'
    allowBlobPublicAccess: true
    supportsHttpsTrafficOnly: true
    minimumTlsVersion: 'TLS1_2'
  }
}

// Blob container for images
resource imagesBlobContainer 'Microsoft.Storage/storageAccounts/blobServices/containers@2023-05-01' = {
  name: '${storageAccount.name}/default/images'
  properties: {
    publicAccess: 'Blob' // Allow public read access to images
  }
}

// User-assigned managed identity for container apps
resource managedIdentity 'Microsoft.ManagedIdentity/userAssignedIdentities@2023-07-31-preview' = {
  name: '${fullAppName}-identity'
  location: location
}

// Role assignment for storage blob data contributor
resource storageRoleAssignment 'Microsoft.Authorization/roleAssignments@2022-04-01' = {
  name: guid(storageAccount.id, managedIdentity.id, 'ba92f5b4-2d11-453d-a403-e96b0029c9fe')
  scope: storageAccount
  properties: {
    roleDefinitionId: subscriptionResourceId('Microsoft.Authorization/roleDefinitions', 'ba92f5b4-2d11-453d-a403-e96b0029c9fe') // Storage Blob Data Contributor
    principalId: managedIdentity.properties.principalId
    principalType: 'ServicePrincipal'
  }
}

// Backend API Container App
resource backendApp 'Microsoft.App/containerApps@2024-03-01' = {
  name: '${fullAppName}-api'
  location: location
  identity: {
    type: 'UserAssigned'
    userAssignedIdentities: {
      '${managedIdentity.id}': {}
    }
  }
  properties: {
    managedEnvironmentId: containerAppsEnvironment.id
    configuration: {
      activeRevisionsMode: 'Single'
      ingress: {
        external: true
        targetPort: 8080
        allowInsecure: false
        traffic: [
          {
            weight: 100
            latestRevision: true
          }
        ]
      }
    }
    template: {
      containers: [
        {
          name: 'api'
          image: 'mcr.microsoft.com/dotnet/samples:aspnetapp' // Placeholder image
          resources: {
            cpu: '0.25'
            memory: '0.5Gi'
          }
          env: [
            {
              name: 'ASPNETCORE_ENVIRONMENT'
              value: environment == 'prod' ? 'Production' : 'Development'
            }
            {
              name: 'ConnectionStrings__DefaultConnection'
              value: 'Host=${postgresqlServer.properties.fullyQualifiedDomainName};Database=votingapp;Username=dbadmin;Password=${dbAdminPassword};SSL Mode=Require'
            }
            {
              name: 'ApplicationInsights__ConnectionString'
              value: appInsights.properties.ConnectionString
            }
            {
              name: 'AzureStorage__AccountName'
              value: storageAccount.name
            }
            {
              name: 'AzureStorage__ContainerName'
              value: 'images'
            }
            {
              name: 'AZURE_CLIENT_ID'
              value: managedIdentity.properties.clientId
            }
          ]
        }
      ]
      scale: {
        minReplicas: 0 // Scale to zero for cost savings
        maxReplicas: 5
      }
    }
  }
}

// Frontend Container App
resource frontendApp 'Microsoft.App/containerApps@2024-03-01' = {
  name: '${fullAppName}-web'
  location: location
  properties: {
    managedEnvironmentId: containerAppsEnvironment.id
    configuration: {
      activeRevisionsMode: 'Single'
      ingress: {
        external: true
        targetPort: 80
        allowInsecure: false
        traffic: [
          {
            weight: 100
            latestRevision: true
          }
        ]
      }
    }
    template: {
      containers: [
        {
          name: 'web'
          image: 'nginx:alpine' // Placeholder image
          resources: {
            cpu: '0.25'
            memory: '0.5Gi'
          }
          env: [
            {
              name: 'VITE_API_BASE_URL'
              value: 'https://${backendApp.properties.configuration.ingress.fqdn}'
            }
          ]
        }
      ]
      scale: {
        minReplicas: 0 // Scale to zero for cost savings
        maxReplicas: 3
      }
    }
  }
}

// Outputs for reference in CI/CD and other templates
output resourceGroupName string = resourceGroup().name
output containerAppsEnvironmentName string = containerAppsEnvironment.name
output backendAppName string = backendApp.name
output frontendAppName string = frontendApp.name
output backendUrl string = 'https://${backendApp.properties.configuration.ingress.fqdn}'
output frontendUrl string = 'https://${frontendApp.properties.configuration.ingress.fqdn}'
output storageAccountName string = storageAccount.name
output postgresqlServerName string = postgresqlServer.name
output databaseName string = postgresqlDatabase.name
output managedIdentityId string = managedIdentity.id
output applicationInsightsName string = appInsights.name