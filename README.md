# Learning to deploy an AKS cluster using Bicep

Testing out the following aspects

1. How to deploy resources
2. how to chain/refer multiple Bicep files
3. Idempotency

# Used Commands

```bash
az deployment group create --resource-group rg-test-2 --template-file aks.bicep --what-if
```
