resource appservplan'Microsoft.Web/serverfarms@2022-03-01' = {
  name:'spnuevoej'
  location:'centralus'
  sku:{
    name:'F1'
    tier:'free'
  }
}
resource webappsrv 'Microsoft.Web/sites@2022-03-01'= {
  name:'webthorapp'
  location:'centralus'
  properties: {
    serverFarmId:appservplan.id
    httpsOnly:true
  }
}
