const express = require('express');
const app  = express();
const http = require('http').Server(app);
const path = require('path')

app.use('/', express.static(path.join(__dirname, '')));

app.get('/', function(req, res) {
  res.sendFile(path.join(__dirname, 'index.html'));
});

http.listen(3000, function(){
  console.log('Listen on localhost:3000');
});