param location string = resourceGroup().location

param ipAddrSecondDigit int = 20
param podSubnetName string = 'pod-subnet'
resource virtualNetwork 'Microsoft.Network/virtualNetworks@2019-11-01' = {
  name: 'vnet-test'
  location: location
  properties: {
    addressSpace: {
      addressPrefixes: [
        '10.${ipAddrSecondDigit}.0.0/16'
      ]
    }
    subnets: [
      {
        name: podSubnetName
        properties: {
          addressPrefix: '10.${ipAddrSecondDigit}.128.0/17'
        }
      }
      {
        name: 'db-01-subnet'
        properties: {
          addressPrefix: '10.${ipAddrSecondDigit}.0.0/24'
        }
      }
      {
        name: 'db-02-subnet'
        properties: {
          addressPrefix: '10.${ipAddrSecondDigit}.1.0/24'
        }
      }
    ]
  }
}

output subnetId string = '${virtualNetwork.id}/subnets/${podSubnetName}'

// az deployment group create --resource-group rg-test-2 --template-file .\vnet.bicep
