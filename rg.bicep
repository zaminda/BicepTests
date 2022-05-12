targetScope = 'subscription'
param location string
resource resourceGroup 'Microsoft.Resources/resourceGroups@2021-04-01' = {
  name: 'rg-test-2'
  location: location
}
