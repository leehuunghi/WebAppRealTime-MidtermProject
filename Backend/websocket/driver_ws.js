var http = require('http'),
    express = require('express');

var router = express.Router();
var sessionstorage = require('sessionstorage');
var server = http.createServer(express);
var io = require('socket.io')(server);
var bookingBikeRepo = require('../repos/driverRepo');
var driverRepo = require('../repos/driverRepo');

var haversine = require('haversine')

io.on('connection', socket => {

    socket.on('subcriseDriver', msg => {
        sessionstorage.setItem('driver1', socket.id);
    })

    socket.on('updateLocationDriver', msg => {
        driverRepo.updatePositionDriver(msg).then(() => {

        }).catch(err => {

        })
    })

    socket.on('updateLocationDriver', msg => {
        driverRepo.updatePositionDriver(msg).then(() => {

        }).catch(err => {

        })
    })

    socket.on('every', msg => {
        
    })

    socket.on('hasRequestBooking', guest => {
        driverRepo.loadAllPositionDriverReady().then(drivers => {
            if (drivers.length > 0) {
                var minIndex = -1;
                var minDistance;
                var guest_loc = {
                    latitude: guest.lat,
                    longtitude: guest.lng
                };
                for (let index = 0; index < drivers.length; index++) {
                    const driver = drivers[index];
                    if (driver.lat && driver.lng) {
                        let driver_loc = {
                            ID: driver.ID,
                            latitude: driver.lat,
                            longtitude: driver.lng
                        }
                        let distance = haversine(guest_loc, driver_loc, { unit: 'meter' });
                        if (!minDistance) {
                            minDistance
                            minDistance = distance;
                            minIndex = index;
                        } else {
                            if (minDistance > distance) {
                                minDistance = distance;
                                minIndex = index;
                            }
                        }
                    }
                }
                console.log(minIndex);
                if (minIndex == 0) {
                    console.log(sessionstorage.getItem('driver1'));
                    if (io.sockets.connected[sessionstorage.getItem('driver1')]) {
                        console.log('co tai xe');
                        io.sockets.connected[sessionstorage.getItem('driver1')].emit('hasRequestBooking', guest_loc);

                    }
                } else {
                    console.log("khong co tai xe");

                }
            }
        })
            .catch(err => {
                console.log(err);
                res.end();
            })

    })
})

server.listen(1412, () => {
    console.log("Socket driver listen port 1412!");
});

module.exports = router;