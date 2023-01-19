param location string
param straccountname string
param appsrvplanname string
param appsrvappname string



@allowed([
  'nonprod'
  'prod'
])
param storageenvironmentType string

var storagesppsrvplanskuname = (storageenvironmentType == 'prod') ? 'P2_V3' : 'F1'

resource straccount 'Microsoft.Storage/storageAccounts@2022-05-01' = {
  name:straccountname
  location: location
  sku: {
    name:storagesppsrvplanskuname
  }
  kind:'StorageV2'
  properties: {
    accessTier:'Hot'
  }
}

module webappsln 'Modulos/appService.bicep'= {
name:'appsrv'
params: {
  location:location
  appsrvplanname:appsrvplanname
  appsrvappname:appsrvappname
  environmentType:storageenvironmentType
}

}

output appSrvHostName string = webappsln.outputs.appsrvAppHostName


