param location string
param appsrvplanname string
param appsrvappname string

@allowed([
  'nonprod'
  'prod'
])
param environmentType string

var sppsrvplanskuname = (environmentType == 'prod') ? 'P2_V3' : 'F1'
var sppsrvplanTiername = (environmentType == 'prod') ? 'PremiumV3' : 'Free'

resource appservplan'Microsoft.Web/serverfarms@2022-03-01' = {
  name:appsrvplanname
  location:location
  sku:{
    name:sppsrvplanskuname
    tier:sppsrvplanTiername
  }
}
resource webappsrv 'Microsoft.Web/sites@2022-03-01'= {
  name:appsrvappname
  location:location
  properties: {
    serverFarmId:appservplan.id
    httpsOnly:true
  }
}

output appsrvAppHostName string = webappsrv.properties.defaultHostName
