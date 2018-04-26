// Add this to the VERY top of the first file loaded in your app
var apm = require('elastic-apm-node').start({
  // Set required service name (allowed characters: a-z, A-Z, 0-9, -, _, and space)
  serviceName: 'test_nodejs',
  // Use if APM Server requires a token
  // secretToken: '',
  // Set custom APM Server URL (default: http://localhost:8200)
  serverUrl: 'http://docker.for.mac.localhost:8200',
})

var app = require('express')()

app.get('/', function (req, res) {
  res.send('Hello World!')
})

app.listen(3000)
