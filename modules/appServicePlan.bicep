param location string
param appServicePlanName string
param appServicePlanSkuName string
param appServicePlanTierName string
param Prefix string


resource appServicePlan 'Microsoft.Web/serverfarms@2022-03-01' = {
  name: '${appServicePlanName}${Prefix}' 
  location: location
  sku: {
    name: appServicePlanSkuName
    tier: appServicePlanTierName
  } 
}

output appServicePlanId string = appServicePlan.id
