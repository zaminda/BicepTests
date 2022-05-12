param location string = resourceGroup().location

resource virtualNetwork 'Microsoft.Network/virtualNetworks@2019-11-01' = {
  name: 'vnet-test'
  location: location
  properties: {
    addressSpace: {
      addressPrefixes: [
        '10.20.0.0/16'
      ]
    }
    subnets: [
      {
        name: 'Subnet-1'
        properties: {
          addressPrefix: '10.20.0.0/24'
        }
      }
      // {
      //   name: 'Subnet-2'
      //   properties: {
      //     addressPrefix: '10.0.1.0/24'
      //   }
      // }
      {
        name: 'Subnet-3'
        properties: {
          addressPrefix: '10.20.2.0/24'
        }
      }
      {
        name: 'pod-subnet'
        properties: {
          addressPrefix: '10.20.128.0/17'
        }
      }
    ]
  }
}

output subnetId string = '${virtualNetwork.id}/subnets/pod-subnet'

// az deployment group create --resource-group rg-test-2 --template-file .\vnet.bicep
