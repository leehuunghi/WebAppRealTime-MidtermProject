var http = require('http'),
    express = require('express');

var router = express.Router();

var server = http.createServer(express);
var io = require('socket.io')(server);

var driverRepo = require('../repos/driverRepo');

var haversine = require('haversine')

io.on('connection', socket => {
    console.log("hello driver");
    socket.on('updateLocationDriver', msg => {
        console.log(msg);
    })
})

server.listen(1412, () => {
    console.log("Socket driver listen port 1412!");
});

module.exports = router;