var http = require('http'),
    express = require('express');

var router = express.Router();

var server = http.createServer(express);
var io = require('socket.io')(server);

var bookingBikeRepo = require('../repos/bookingBikeRepo');
var driverRepo = require('../repos/driverRepo');

var haversine = require('haversine')

io.on('connection', socket => {
    console.log('a user connected');

    socket.on('disconnect', () => {
        console.log('user disconnected');
    });

    socket.on('finishIdentifyLocation', guest => {
        console.log(guest);
        // bookingBikeRepo.loadAllLocationDriver().then(drivers => {
        //     if (drivers.length > 0) {
        //         var min;
        //         var guest_loc = {
        //             latitude: guest.lat,
        //             longtitude: guest.lng
        //         };
        //         drivers.map(driver => {
        //             let driver_loc = {
        //                 latitude: driver.lat,
        //                 longtitude: driver.lng
        //             }
        //             let distance = haversine(guest_loc, driver_loc, {unit: 'meter'});
        //             if (distance > 0)
        //             if (!min) {
        //                 min = distance;
        //             } else {
        //                 if (min > distance) min = distance;
        //             }
        //         })
        //     }
        // })
        // .catch(err => {
        //     console.log(err);
        //     res.end();
        // })
    });
});

server.listen(3030, () => {
    console.log("Socket listen port 3030!");
});

module.exports = router;