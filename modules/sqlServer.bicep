param location string
param serverName string
param serverAdministratorLogin string
@secure()
param serverAdministratorLoginPassword string
param minimalTlsVersion string
param publicNetworkAccess string
param restrictOutboundNetworkAccess string
param Prefix string

resource sqlServer 'Microsoft.Sql/servers@2022-05-01-preview' = {
  name: '${serverName}${Prefix}' 
  location: location
  properties: {
    administratorLogin: serverAdministratorLogin
    administratorLoginPassword: serverAdministratorLoginPassword
    minimalTlsVersion: minimalTlsVersion
    publicNetworkAccess: publicNetworkAccess
    restrictOutboundNetworkAccess: restrictOutboundNetworkAccess
  }
}
output sqlServerName string = sqlServer.name
