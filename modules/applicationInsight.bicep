param appInsigthsName string
param appInsigthstype string
param location string
param appInsigthsrequestSource string
param appInsigthsflowType string
param Prefix string


resource appInsight 'Microsoft.Insights/components@2020-02-02' = {
  name: '${appInsigthsName}${Prefix}' 
  location: location
  kind: appInsigthstype
  properties: {
    Application_Type: appInsigthstype
    Flow_Type: appInsigthsflowType
    Request_Source: appInsigthsrequestSource
  }
}

output appInsights_instKey string = appInsight.properties.InstrumentationKey
output appInsights_connSting string = appInsight.properties.ConnectionString
