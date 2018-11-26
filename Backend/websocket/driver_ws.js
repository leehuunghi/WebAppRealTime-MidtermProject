var http = require('http'),
    express = require('express');

var router = express.Router();
var sessionstorage = require('sessionstorage');
var server = http.createServer(express);
var io = require('socket.io')(server);
var bookingBikeRepo = require('../repos/bookingBikeRepo');
var driverRepo = require('../repos/driverRepo');

var haversine = require('haversine')

io.on('connection', socket => {

    socket.on('subcriseDriver', username => {
        console.log("subcrise");
        console.log(username._value);
        sessionstorage.setItem(username._value, socket.id);
    })

    socket.on('updateLocationDriver', msg => {
        console.log(msg);
        driverRepo.updatePositionDriver(msg).then(() => {

        }).catch(err => {

        })
    })

    socket.on('every', msg => {
        
    })

    socket.on('hasRequestBooking', guest => {
        var tmp2=guest;
        var sendUsername = tmp2.guest.usernameDriver;
        driverRepo.loadAllPositionDriverReady(sendUsername).then(drivers => {
            console.log(drivers);
            var tmp = guest;
            if (drivers.length > 0) {
                var minIndex = -1;
                var minDistance;
     
                var guest_loc = {
                    // ID: tmp.guest.ID,
                    latitude: tmp.guest.lat,
                    longitude: tmp.guest.lng
                };
                console.log(guest_loc);

                for (let index = 0; index < drivers.length; index++) {
                    const driver = drivers[index];
                    if (driver.lat && driver.lng) {
                        let driver_loc = {
                            // ID: driver.ID,
                            latitude: driver.lat,
                            longitude: driver.lng
                        }
                        console.log(driver_loc);
                        let distance = haversine(guest_loc, driver_loc, { unit: 'meter' });
                        console.log(distance);
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
                var name = drivers[minIndex].username;
                var guest_sent = {
                    ID: tmp.guest.ID,
                    latitude: tmp.guest.lat, 
                    longitude: tmp.guest.lng
                };
                console.log(name);
                    console.log(sessionstorage.getItem(name));
                    if (io.sockets.connected[sessionstorage.getItem(name)]) {
                        console.log('co tai xe');
                        io.sockets.connected[sessionstorage.getItem(name)].emit('hasRequestBooking', guest_sent);

                    }
                
            }
            else {
                console.log("khong co tai xe");

            }
        })
            .catch(err => {
                console.log(err);
                res.end();
            })

    })

    socket.on('getInfoRequestByRequestID', driverID => {
        bookingBikeRepo.getInfoRequestByRequestID(driverID).then(value => {
            socket.emit('getInfoRequestByRequestIDEvent', value);
        }).catch(err => {
            console.log(err);
        })
    })

    socket.on('updateStatusRequestBooking', guest => {
        console.log("ddaay");
        bookingBikeRepo.updateStatusBooking(guest).then(() => {
            
        }).catch(err => {
            console.log(err);
        })
    })
})

server.listen(1412, () => {
    console.log("Socket driver listen port 1412!");
});

module.exports = router;