param serviceBusNamespaceName string
param location string
param ServiceBustier string
param serviceBusQueueNames array
param serviceBusDisableLocalAuth bool
param serviceBusRigths array
param serviceBusLockDuration string
param serviceBusmaxSizeInMegabytes int
param serviceBusrequiresDuplicate bool
param serviceBusrequiresSession bool
param serviceBusdefaultMessageTime string
param servicedeadLetteringOnMessageExpiration bool
param serviceBusduplicateDetectionHistoryTimeWindow string
param serviceBusMaxDeliveryCount int
param serviceBusEnablePartitioning bool
param serviceBusEnableExpress bool
param Prefix string


resource serviceBusNamespace 'Microsoft.ServiceBus/namespaces@2021-11-01' = {
  name: '${serviceBusNamespaceName}${Prefix}' 
  location: location
  sku: {
    name: ServiceBustier
  }
  properties: {
    disableLocalAuth:serviceBusDisableLocalAuth
  }
}

resource serviceBusRigth 'Microsoft.ServiceBus/namespaces/AuthorizationRules@2021-11-01' = {
  name:'serviceBusRigth'
  parent: serviceBusNamespace
  properties:{
    rights: serviceBusRigths
  }
 }
 

 resource serviceBusQueue 'Microsoft.ServiceBus/namespaces/queues@2021-11-01' = [for i in range(0, length(serviceBusQueueNames)):{
  parent: serviceBusNamespace
  name: serviceBusQueueNames[i]
  properties: {
    lockDuration: serviceBusLockDuration
    maxSizeInMegabytes: serviceBusmaxSizeInMegabytes
    requiresDuplicateDetection: serviceBusrequiresDuplicate
    requiresSession: serviceBusrequiresSession
    defaultMessageTimeToLive: serviceBusdefaultMessageTime
    deadLetteringOnMessageExpiration: servicedeadLetteringOnMessageExpiration
    duplicateDetectionHistoryTimeWindow: serviceBusduplicateDetectionHistoryTimeWindow
    maxDeliveryCount: serviceBusMaxDeliveryCount
    autoDeleteOnIdle: serviceBusdefaultMessageTime
    enablePartitioning: serviceBusEnablePartitioning
    enableExpress: serviceBusEnableExpress
  }
}]
