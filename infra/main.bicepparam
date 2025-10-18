using 'main.bicep'

// Parameters for the development environment
param environment = 'dev'
param appName = 'catvdog'
param location = 'East US'
param dbAdminPassword = readEnvironmentVariable('DB_ADMIN_PASSWORD', 'TempPassword123!') // Set this in your environment
param containerRegistryLoginServer = '' // Leave empty to create new ACR if needed