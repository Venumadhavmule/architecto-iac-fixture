param location string = resourceGroup().location
param storageAccountName string = 'architectofix${uniqueString(resourceGroup().id)}'

resource storage 'Microsoft.Storage/storageAccounts@2023-01-01' = {
  name: storageAccountName
  location: location
  sku: {
    name: 'Standard_LRS'
  }
  kind: 'StorageV2'
  properties: {
    allowBlobPublicAccess: true
    minimumTlsVersion: 'TLS1_2'
  }
}

resource plan 'Microsoft.Web/serverfarms@2023-01-01' = {
  name: 'architecto-fixture-plan'
  location: location
  sku: {
    name: 'B1'
    tier: 'Basic'
  }
}

resource app 'Microsoft.Web/sites@2023-01-01' = {
  name: 'architecto-fixture-app-${uniqueString(resourceGroup().id)}'
  location: location
  properties: {
    serverFarmId: plan.id
    httpsOnly: true
  }
}

output storageId string = storage.id
output appHostName string = app.properties.defaultHostName
