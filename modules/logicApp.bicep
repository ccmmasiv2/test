param location string
param storageAccountSku string
param logicAppName string
param logicAppStorageName string
param logicAppStorageKind string
param logicAppallowBlobPublicAccess bool
param logicAppAccessTier string
param logicAppsupportsHttpsTrafficOnly bool
param minimumElasticSize int
param maximumElasticSize int
param laMinTlsVersion string
param laServicePlanName string
param laServicePlanSkuTier string
param laServicePlanSkuName string
param laServiceContent string
param laExtensionID string
param laExtensionName string
param laAppKind string
param laelasticScaleEnabled bool
param laIsSpot bool
param lazoneRedundant bool
param laKind string
param laWorkerProcess bool
param laAffinityEnabled bool
param appInsights_instKey string
param appInsights_connSting string
param Prefix string


// Storage account for service ///
 resource logicAppStorage 'Microsoft.Storage/storageAccounts@2019-06-01' = {
   name: '${logicAppStorageName}${Prefix}' 
   location: location
   kind: logicAppStorageKind
   sku: {
     name: storageAccountSku
   }
   properties: {
     allowBlobPublicAccess: logicAppallowBlobPublicAccess
     accessTier: logicAppAccessTier
     supportsHttpsTrafficOnly: logicAppsupportsHttpsTrafficOnly
     minimumTlsVersion: laMinTlsVersion
   }
 }

 
 /// Dedicated app plan for the service ///
 resource servicePlanLogicApp 'Microsoft.Web/serverfarms@2021-02-01' = {
   name: '${laServicePlanName}${Prefix}' 
   location: location
   sku: {
     tier: laServicePlanSkuTier
     name: laServicePlanSkuName
   }
   properties: {
     targetWorkerCount: minimumElasticSize
     maximumElasticWorkerCount: maximumElasticSize
     elasticScaleEnabled: laelasticScaleEnabled
     isSpot: laIsSpot
     zoneRedundant: lazoneRedundant
   }
 }
    

 // App service containing the workflow runtime ///
 resource siteLogicApp 'Microsoft.Web/sites@2021-02-01' = {
   name: '${logicAppName}${Prefix}' 
   location: location
   kind: laKind
   properties: {
     httpsOnly: true
     siteConfig: {
       appSettings: [
         {
           name: 'AzureWebJobsStorage'
           value: 'DefaultEndpointsProtocol=https;AccountName=${logicAppStorage.name};AccountKey=${listKeys(logicAppStorage.id, '2019-06-01').keys[0].value};EndpointSuffix=core.windows.net'
         }
         {
           name: 'WEBSITE_CONTENTAZUREFILECONNECTIONSTRING'
           value: 'DefaultEndpointsProtocol=https;AccountName=${logicAppStorage.name};AccountKey=${listKeys(logicAppStorage.id, '2019-06-01').keys[0].value};EndpointSuffix=core.windows.net'
         }
         {
           name: 'WEBSITE_CONTENTSHARE'
           value: laServiceContent
         }
         {
           name: 'AzureFunctionsJobHost__extensionBundle__id'
           value: laExtensionID 
         }
         {
           name: 'AzureFunctionsJobHost__extensionBundle__version'
           value: laExtensionName
         }
         {
           name: 'APP_KIND'
           value: laAppKind
         }
         {
           name: 'APPINSIGHTS_INSTRUMENTATIONKEY'
           value: appInsights_instKey
         }
         {
           name: 'ApplicationInsightsAgent_EXTENSION_VERSION'
           value: '~2'
         }
         {
           name: 'APPLICATIONINSIGHTS_CONNECTION_STRING'
           value: appInsights_connSting
         }
       ]
       use32BitWorkerProcess: laWorkerProcess
     }
     serverFarmId: servicePlanLogicApp.id     
     clientAffinityEnabled: laAffinityEnabled
   }
 }
