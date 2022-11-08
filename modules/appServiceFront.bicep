param location string
param appServicePlanId string
param appServiceName string
param httpsOnly bool
param minTlsVersion string
param FrameworkVersion string
param alwaysOn bool
param managedPipelineMode string
param webSocketsEnabled bool
param remoteDebuggingEnabled bool
param http20Enabled bool
param cors_supportCredentials bool
param clientAffinityEnabled bool
param clientCertEnabled bool
param appInsights_instKey string
param appInsights_connSting string
param Prefix string


/*App Service .NodeJS*/
resource appServiceApp2 'Microsoft.Web/sites@2022-03-01' = {
  name: '${appServiceName}${Prefix}' 
  location: location
  properties: {
    serverFarmId: appServicePlanId
    httpsOnly: httpsOnly
    siteConfig: {
      minTlsVersion: minTlsVersion
      nodeVersion: FrameworkVersion
      alwaysOn: alwaysOn
      managedPipelineMode: managedPipelineMode
      webSocketsEnabled: webSocketsEnabled
      remoteDebuggingEnabled: remoteDebuggingEnabled
      http20Enabled: http20Enabled
      cors: {
        supportCredentials: cors_supportCredentials
      }
      appSettings: [
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
    }
    clientAffinityEnabled: clientAffinityEnabled
    clientCertEnabled: clientCertEnabled
  }
}

output appServiceAppId string = appServiceApp2.id
