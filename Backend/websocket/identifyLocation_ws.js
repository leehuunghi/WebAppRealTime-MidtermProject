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

    socket.on('updateStatusBooking', msg => {
        bookingBikeRepo.updateStatus(msg).then(() => {
            io.emit('updateStatusBookingEvent', msg);
        }).catch(err => {
            console.log(err);
        })
    });

    socket.on('finishIdentifyLocation', msg => {
        bookingBikeRepo.updateLocationGuest(msg).then(() => {
            io.emit('updateStatusBookingEvent', {
                ID: msg.ID,
                status: 'identify done'
            });

            var guestPostion = {
                lat: msg.lat,
                lng: msg.lng
            }

            //find driver]
            var driver;
            driverRepo.loadAllPositionDriverReady().then(values => {
                let min;
                    for (let i = 0; i < localStorage.getItem(localStorage.getItem('countFindDriver')); i++) {
                            for (let index = 0; index < values.length; index++) {
                                const driverPosition = {
                                    lat: values[index].lat,
                                    lng: values[index].lng
                                }
                                distance = haversine(guestPostion, driverPosition, {unit: 'km'});
                                if (!min) {
                                    min = distance;
                                    driver = values[index];
                                }
                                else if (distance < min) {
                                    min = distance;
                                    driver = values[index];
                                }
                            }
                            if (min) break;
                        }
            })

            if (driver) {
                
            } else {

            }

        }).catch(err => {
            console.log(err);
        });
    });
});

server.listen(3030, () => {
    console.log("Socket listen port 3030!");
});

module.exports = router;