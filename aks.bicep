param location string = resourceGroup().location

module vnet 'vnet.bicep' = {
  name: 'vnetDeploy'
  params: {
    location: location
  }
}

resource aksCluster 'Microsoft.ContainerService/managedClusters@2021-03-01' = {
  name: 'aks-test-1'
  location: location
  identity: {
    type: 'SystemAssigned'
  }
  properties: {
    kubernetesVersion: '1.23.5'
    dnsPrefix: 'dnsprefix'
    enableRBAC: true
    agentPoolProfiles: [
      {
        name: 'agentpool'
        count: 1
        vmSize: 'Standard_b2s'
        osType: 'Linux'
        mode: 'System'
        vnetSubnetID: vnet.outputs.subnetId
        availabilityZones: [
          '1'
          '2'
          '3'
        ]
      }
      {
        name: 'agentpool2'
        count: 1
        vmSize: 'Standard_b2s'
        osType: 'Linux'
        mode: 'User'
        vnetSubnetID: vnet.outputs.subnetId
        availabilityZones: [
          '1'
          '2'
          '3'
        ]
      }
    ]
    networkProfile: {
      networkPlugin: 'azure'
      loadBalancerSku: 'standard'
    }
  }
}
