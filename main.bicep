/*============================================================================================================================================*/
/*                                                  PARAMETROS DE EJECUCIÓN DE SERVICIOS                                                      */
/*============================================================================================================================================*/

/*Parametros service app plan*/
@description('Which Azure Region to deploy the resource to. This must be a valid Azure regionId.')
param location string

@description('App Service Plan name')
param appServicePlanName string

@description('App Service Plan sku')
param appServicePlanSkuName string

@description('App Service Plan tier')
param appServicePlanTierName string

/*Parametros ejecución app services*/
@description('App Services Back Names')
param appServiceBackNames array

@description('App Services Front Names')
param appServiceFrontNames array

@description('Https Only.')
param httpsOnly array

@description('Minimun TLS Versión.')
param minTlsVersion array

@description('Framework name.')
param FrameworkName array

@description('Framework version.')
param FrameworkVersion array

@description('AlwaysOn.')
param alwaysOn array

@description('Managed pipeline mode.')
param managedPipelineMode array

@description('Web socket enable.')
param webSocketsEnabled array

@description('Remote debugging.')
param remoteDebuggingEnabled array

@description('Http 2.0 Enabled.')
param http20Enabled array

@description('Cors Support Credentials.')
param cors_supportCredentials array

@description('Cors Allow Origins.')
param cors_allowedOrigins array

@description('Client Affinity Enabled.')
param clientAffinityEnabled array

@description('Client Certificate Enabled.')
param clientCertEnabled array

/*Parametros de creación de sql server y BD*/
@description('Server DB Name.')
param serverName string

@description('DB Name.')
param DBName array

@description('DB Collation.')
param DBCollation array

@description('Server user.')
param administratorLogin string
@secure()
@description('Server Password.')
param administratorLoginPassword string

@description('Minimal TLS Versión.')
param minimalTlsVersion string

@description('Public Network Access.')
param publicNetworkAccess string

@description('Restrict Outbound Network Access.')
param restrictOutboundNetworkAccess string

@description('DB Tier.')
param databasTier array

@description('DB DTU.')
param databaseDTU array

@description('DB Max Size.')
param databaseMaxSize array

/*Parametros service bus queues*/
@description('Name of the Service Bus namespace')
param serviceBusNamespaceName string

@description('Nombre de colas de mensajeria')
param serviceBusQueueNames array

@description('Service Bus Tier.')
param ServiceBustier string

@description('Service Bus Disable Local Auth.')
param serviceBusDisableLocalAuth bool

@description('Service Bus Rigths.')
param serviceBusRigths array

@description('Service Bus Lock Duration.')
param serviceBusLockDuration string

@description('Service Bus Max Size In Megabytes.')
param serviceBusmaxSizeInMegabytes int

@description('Service Bus Requires Duplicate.')
param serviceBusrequiresDuplicate bool

@description('Service Bus Requires Session.')
param serviceBusrequiresSession bool

@description('Service Bus Default Message Time.')
param serviceBusdefaultMessageTime string

@description('Servicev Dead Lettering On Message Expiration.')
param servicedeadLetteringOnMessageExpiration bool

@description('Service Bus Duplicate Detection History TimeWindow.')
param serviceBusduplicateDetectionHistoryTimeWindow string

@description('Service Bus Max Delivery Count.')
param serviceBusMaxDeliveryCount int

@description('Service Bus Enable Partitioning.')
param serviceBusEnablePartitioning bool

@description('Service Bus Enable Expres.')
param serviceBusEnableExpress bool

/*Parametros de Key Vault*/
@description('Name of the key vault')
param keyVaultName string

@description('Bypass of the key vault')
param keyVaultBypass string

@description('Default action key vault')
param keyVaultDefaultAction string

@description('key Vault Enabled For Deployment')
param keyVaultenabledForDeployment bool

@description('Key Vault Enabled For Disk Encryption')
param keyVaultenabledForDiskEncryption bool

@description('Enable for template deployment flag')
param keyVaultenabledForTemplateDeployment bool

@description('Nombre del sku del key vault')
param skuName string

@description('Key Vault Family')
param keyVaultFamily string

/*Parametros de Application Insigths*/
@description('Name of Application Insights resource.')
param appInsigthsName string

@description('Type of app you are deploying. This field is for legacy reasons and will not impact the type of App Insights resource you deploy.')
param appInsigthstype string

@description('Source of Azure Resource Manager deployment')
param appInsigthsrequestSource string

@description('Source of Azure Resource Manager deployment')
param appInsigthsflowType string

/*Parametros de app logic*/
@description('Storage Account Sku')
param storageAccountSku string

@description('Logic App Name')
param logicAppName string

@description('Logic App Storage Name')
param logicAppStorageName string

@description('Logic App Storage Kind')
param logicAppStorageKind string

@description('Logic App Blob Public Access')
param logicAppallowBlobPublicAccess bool

@description('Logic App Access Tier')
param logicAppAccessTier string

@description('Logic App Supports Https Traffic Only')
param logicAppsupportsHttpsTrafficOnly bool

@description('Logic App Minimun')
param minimumElasticSize int

@description('Logic App Maximum')
param maximumElasticSize int

@description('Logic App Min TLS Version')
param laMinTlsVersion string

@description('Logic App Service Plan Name')
param laServicePlanName string

@description('Logic App Service Plan SKU Tier')
param laServicePlanSkuTier string

@description('Logic App Sku Name')
param laServicePlanSkuName string

@description('Logic App Service Content')
param laServiceContent string

@description('Logic App Extension Id')
param laExtensionID string

@description('Logic App Extension Name')
param laExtensionName string

@description('Logic App Kind')
param laAppKind string

@description('Logic App Elastic Scale Enabled')
param laelasticScaleEnabled bool

@description('Logic App Is Spot')
param laIsSpot bool

@description('Logic App Zone Redundant')
param lazoneRedundant bool

@description('Logic App Kind')
param laKind string

@description('Logic App Worker Process')
param laWorkerProcess bool

@description('Logic App Affinity')
param laAffinityEnabled bool

@description('Prejijo diferenciador')
param Prefix string

/*============================================================================================================================================*/
/*                                                  GENERACIÓN DE SERVICIOS                                                                   */
/*============================================================================================================================================*/

/*1. Creación de Service App Plan*/
module appServicePlan 'modules/appServicePlan.bicep' = {
  name: 'appServicePlan'
  params: {
    location: location
    appServicePlanName: appServicePlanName
    appServicePlanSkuName: appServicePlanSkuName
    appServicePlanTierName: appServicePlanTierName
    Prefix: Prefix
  }
}
var appServicePlanId = appServicePlan.outputs.appServicePlanId

/*2. Creación de Application Insights*/
module applicationInsights 'modules/applicationInsight.bicep' = {
  name: 'applicationInsights'
  params: {
    appInsigthsName: appInsigthsName
    appInsigthstype: appInsigthstype
    appInsigthsrequestSource: appInsigthsrequestSource
    location: location
    appInsigthsflowType: appInsigthsflowType
    Prefix: Prefix
  }
}
var appInsights_instKey = applicationInsights.outputs.appInsights_instKey
var appInsights_connSting = applicationInsights.outputs.appInsights_connSting

/*3. Creación de App Services back*/
module appService1 'modules/appServiceBack.bicep' = [for i in range(0, length(appServiceBackNames)): if (FrameworkName[i] == '.NET') {
  name: appServiceBackNames[i]
  dependsOn: [ appServicePlan ]
  params: {
    location: location
    appServicePlanId: appServicePlanId
    appServiceName: appServiceBackNames[i]
    httpsOnly: httpsOnly[i]
    minTlsVersion: minTlsVersion[i]
    FrameworkVersion: FrameworkVersion[i]
    alwaysOn: alwaysOn[i]
    managedPipelineMode: managedPipelineMode[i]
    webSocketsEnabled: webSocketsEnabled[i]
    remoteDebuggingEnabled: remoteDebuggingEnabled[i]
    http20Enabled: http20Enabled[i]
    cors_supportCredentials: cors_supportCredentials[i]
    cors_allowedOrigins: cors_allowedOrigins[i]
    clientAffinityEnabled: clientAffinityEnabled[i]
    clientCertEnabled: clientCertEnabled[i]
    appInsights_instKey: appInsights_instKey
    appInsights_connSting: appInsights_connSting
    Prefix: Prefix
  }
}]

/*4. Creación de App Services front*/
//@batchSize(1)
module appService2 'modules/appServiceFront.bicep' = [for i in range(0, length(appServiceFrontNames)): if (FrameworkName[i] == 'Node') {
  name: appServiceFrontNames[i]
  dependsOn: [ appServicePlan ]
  params: {
    location: location
    appServicePlanId: appServicePlanId
    appServiceName: appServiceFrontNames[i]
    httpsOnly: httpsOnly[i]
    minTlsVersion: minTlsVersion[i]
    FrameworkVersion: FrameworkVersion[i]
    alwaysOn: alwaysOn[i]
    managedPipelineMode: managedPipelineMode[i]
    webSocketsEnabled: webSocketsEnabled[i]
    remoteDebuggingEnabled: remoteDebuggingEnabled[i]
    http20Enabled: http20Enabled[i]
    cors_supportCredentials: cors_supportCredentials[i]
    clientAffinityEnabled: clientAffinityEnabled[i]
    clientCertEnabled: clientCertEnabled[i]
    appInsights_instKey: appInsights_instKey
    appInsights_connSting: appInsights_connSting
    Prefix: Prefix
  }
}]

/*5. Creación de Service Bus Namespace y Queues*/
module serviceBusNamespace 'modules/serviceBus.bicep' = {
  name: 'serviceBusNamespace'
  params: {
    serviceBusNamespaceName: serviceBusNamespaceName
    location: location
    ServiceBustier: ServiceBustier
    serviceBusQueueNames: serviceBusQueueNames
    serviceBusDisableLocalAuth: serviceBusDisableLocalAuth
    serviceBusRigths: serviceBusRigths
    serviceBusLockDuration: serviceBusLockDuration
    serviceBusmaxSizeInMegabytes: serviceBusmaxSizeInMegabytes
    serviceBusrequiresDuplicate: serviceBusrequiresDuplicate
    serviceBusrequiresSession: serviceBusrequiresSession
    serviceBusdefaultMessageTime: serviceBusdefaultMessageTime
    servicedeadLetteringOnMessageExpiration: servicedeadLetteringOnMessageExpiration
    serviceBusduplicateDetectionHistoryTimeWindow: serviceBusduplicateDetectionHistoryTimeWindow
    serviceBusMaxDeliveryCount: serviceBusMaxDeliveryCount
    serviceBusEnablePartitioning: serviceBusEnablePartitioning
    serviceBusEnableExpress: serviceBusEnableExpress
    Prefix: Prefix
  }
}

/*6. Creación de almacen de claves*/
module keyVault 'modules/keyVault.bicep' = {
  name: 'keyvaultspace${Prefix}' 
  params: {
    keyVaultBypass: keyVaultBypass
    keyVaultDefaultAction: keyVaultDefaultAction
    keyVaultenabledForDeployment: keyVaultenabledForDeployment
    keyVaultenabledForDiskEncryption: keyVaultenabledForDiskEncryption
    keyVaultenabledForTemplateDeployment: keyVaultenabledForTemplateDeployment
    keyVaultFamily: keyVaultFamily
    keyVaultName: keyVaultName
    location: location
    skuName: skuName
    Prefix: Prefix
  }
}

/*7. Creación de Logic App*/
module logicApp 'modules/logicApp.bicep' = {
  name: 'logicApp'
  params: {
    location: location
    storageAccountSku: storageAccountSku
    logicAppName: logicAppName
    logicAppStorageName: logicAppStorageName
    logicAppStorageKind: logicAppStorageKind
    logicAppallowBlobPublicAccess: logicAppallowBlobPublicAccess
    logicAppAccessTier: logicAppAccessTier
    logicAppsupportsHttpsTrafficOnly: logicAppsupportsHttpsTrafficOnly
    minimumElasticSize: minimumElasticSize
    maximumElasticSize: maximumElasticSize
    laMinTlsVersion: laMinTlsVersion
    laServicePlanName: laServicePlanName
    laServicePlanSkuTier: laServicePlanSkuTier
    laServicePlanSkuName: laServicePlanSkuName
    laServiceContent: laServiceContent
    laExtensionID: laExtensionID
    laAppKind: laAppKind
    laExtensionName: laExtensionName
    laelasticScaleEnabled: laelasticScaleEnabled
    laIsSpot: laIsSpot
    lazoneRedundant: lazoneRedundant
    laKind: laKind
    laWorkerProcess: laWorkerProcess
    laAffinityEnabled: laAffinityEnabled
    appInsights_instKey: appInsights_instKey
    appInsights_connSting: appInsights_connSting
    Prefix: Prefix
  }
}

/*8. Creación de SQL Server*/
module sqlServer 'modules/sqlServer.bicep' = {
  name: serverName
  params: {
    serverName: serverName
    location: location
    serverAdministratorLogin: administratorLogin
    serverAdministratorLoginPassword: administratorLoginPassword
    minimalTlsVersion: minimalTlsVersion
    publicNetworkAccess: publicNetworkAccess
    restrictOutboundNetworkAccess: restrictOutboundNetworkAccess
    Prefix: Prefix
  }
}
var sqlServerName = sqlServer.outputs.sqlServerName

/*9. Creación de SQL Databases*/
module sqlServerDB 'modules/sqlDatabase.bicep' = [for i in range(0, length(DBName)): {
  name: DBName[i]
  dependsOn: [ sqlServer ]
  params: {
    databaseServerName: sqlServerName
    location: location
    databaseCollation: DBCollation[i]
    databaseName: DBName[i]
    databasTier: databasTier[i]
    databaseDTU: databaseDTU[i]
    databaseMaxSize: databaseMaxSize[i]
    Prefix: Prefix
  }
}]
