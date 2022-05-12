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
    windowsProfile: {
      adminUsername: 'azureuser'
      adminPassword: 'myLJHLSIhldnldsngoldksgnklfng!'
      licenseType: 'Windows_Server'
    }
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
    ]
    networkProfile: {
      networkPlugin: 'azure'
      loadBalancerSku: 'standard'
    }
  }
}

// resource symbolicname 'Microsoft.ContainerService/managedClusters/agentPools@2022-03-01' = {
//   name: 'win01'
//   parent: aksCluster
//   properties: {
//     count: 1
//     vmSize: 'Standard_b2s'
//     osType: 'Windows'
//     mode: 'User'
//     vnetSubnetID: vnet.outputs.subnetId
//     availabilityZones: [
//       '1'
//       '2'
//       '3'
//     ]
//   }
// }

resource symbolicname 'Microsoft.ContainerService/managedClusters/agentPools@2022-03-01' = {
  name: 'lin2'
  parent: aksCluster
  properties: {
    count: 2
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
}
