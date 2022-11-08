param keyVaultName string
param location string
param keyVaultenabledForDeployment bool
param keyVaultenabledForDiskEncryption bool
param keyVaultenabledForTemplateDeployment bool
param tenantId string = subscription().tenantId
@allowed([
  'standard'
  'premium'
])
param skuName string
param keyVaultDefaultAction string
param keyVaultBypass string
param keyVaultFamily string
param Prefix string



resource kv 'Microsoft.KeyVault/vaults@2022-07-01' = {
  name: '${keyVaultName}${Prefix}' 
  location: location
  properties: {
    accessPolicies: []
    enabledForDeployment: keyVaultenabledForDeployment
    enabledForDiskEncryption: keyVaultenabledForDiskEncryption
    enabledForTemplateDeployment: keyVaultenabledForTemplateDeployment
    tenantId: tenantId
    sku: {
      name: skuName
      family: keyVaultFamily
    }
    networkAcls: {
      defaultAction: keyVaultDefaultAction
      bypass: keyVaultBypass
    }
  }
}
