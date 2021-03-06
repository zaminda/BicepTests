param location string = resourceGroup().location
param vnetSubnetID string
@secure()
param adminUsername string
@secure()
param adminPassword string

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
      adminUsername: adminUsername
      adminPassword: adminPassword
      licenseType: 'Windows_Server'
    }
    agentPoolProfiles: [
      {
        name: 'agentpool'
        count: 1
        vmSize: 'Standard_b2s'
        osType: 'Linux'
        mode: 'System'
        vnetSubnetID: vnetSubnetID
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

resource symbolicname 'Microsoft.ContainerService/managedClusters/agentPools@2022-03-01' = {
  name: 'win01'
  parent: aksCluster
  properties: {
    count: 1
    vmSize: 'Standard_b2s'
    osType: 'Windows'
    mode: 'User'
    vnetSubnetID: vnetSubnetID
    availabilityZones: [
      '1'
      '2'
      '3'
      aksCluster.properties
    ]
  }
}


