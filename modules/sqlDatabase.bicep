param databaseServerName string
param location string
param databaseCollation string
param databaseName string
param databasTier string
param databaseDTU int
param databaseMaxSize int
param Prefix string


resource db 'Microsoft.Sql/servers/databases@2021-11-01' = {
  name: '${databaseServerName}/${databaseName}${Prefix}' 
  location: location
  sku: {
    name: databasTier
    tier: databasTier
    capacity: databaseDTU
  }
  properties: {
    collation: databaseCollation
    maxSizeBytes: databaseMaxSize
    catalogCollation:databaseCollation
  }
}
