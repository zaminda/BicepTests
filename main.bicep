// Create a resource group
targetScope = 'subscription'

param location string = 'australiaeast'

@ allowed(['prod', 'dev', 'test'])
param affix string

var resourceGroupName string = 'rg-${affix}-app'

resource rg 'Microsoft.Resources/resourceGroups@2021-04-01' = {
  name: resourceGroupName
  location: location
}

// Create Virtual Network

module vnet 'vnet.bicep' = {
  name: 'virtualNetwork'
  scope: rg
  params: {
    location: resourceGroup().location
  }
}

module aks 'aks.bicep' = {
  name: 'aksDeployment'
  scope: rg
  params: {
    adminPassword: 'KJ8788*HFDS*8NFsddf(&)'
    adminUsername: 'adminuser'
    vnetSubnetID: vnet.outputs.subnetId
    location: location
  }
}


