var http = require('http'),
    express = require('express');

var router = express.Router();

var server = http.createServer(express);
var io = require('socket.io')(server);

var bookingBikeRepo = require('../repos/bookingBikeRepo');
var driverRepo = require('../repos/driverRepo');

var haversine = require('haversine');

io.on('connection', socket => {
    console.log("a user " + socket.id);

    socket.on('disconnect', () => {
        console.log('user disconnected');
    });

    socket.on('updateStatusBookingEvent', msg => {
        io.sockets.emit('updateStatusBookingEvent', msg);
    })

    socket.on('updateLocationDriver', username => {
        // io.sockets.emit('updateLocationDriverEvent', msg);
        driverRepo.getInfoDriverByDriverUsername(username).then(value => {
            io.sockets.emit('getInfoDriverByDriverIDEvent', value[0]);
        }).catch(err => {
            console.log(err);
        })
    })

    socket.on('addNewRequestBooking', msg => {
        console.log(msg);
        io.sockets.emit('addNewRequestBookingEvent', msg[0]);
    })

    socket.on('getInfoDriverByDriverID', driverID => {
        driverRepo.getInfoDriverByDriverID(driverID).then(value => {
            socket.emit('getInfoDriverByDriverIDEvent', value);
        }).catch(err => {
            console.log(err);
        })
    })

    socket.on('error', err => {
        console.log(err);
    })
});



server.listen(3030, () => {
    console.log("Socket identify location listen port 3030!");
});

module.exports = router;