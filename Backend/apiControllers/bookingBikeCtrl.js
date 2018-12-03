var http = require('http'),
    express = require('express');
var router = express.Router();
var moment = require('moment');
var haversine = require('haversine');

var events = require('../event/events');
var socketManager = require('socket.io-client')('http://localhost:3030');
var socketDriver = require('socket.io-client')('http://localhost:1412');

var bookingBikeRepo = require('../repos/bookingBikeRepo');
var driverRepo = require('../repos/driverRepo');


router.get('/loadAllRequestBookingWaiting', (req, res) => {
    bookingBikeRepo.loadAllRequestBookingWaiting().then(values => {
        res.statusCode = 200;
        res.json({
            listRequestBooking: values
        });
    }).catch(err => {
        console.log(err);
        res.statusCode = 500;
    })
})

router.get('/loadAllRequestBooking', (req, res) => {
    bookingBikeRepo.loadAll().then(values => {
        res.statusCode = 200;
        res.json({
            listRequestBooking: values
        });
    }).catch(err => {
        console.log(err);
        res.statusCode = 500;
    })
})

router.get('/requestBookingEvent', events.subscribeRequestBooking);

router.post('/verifyRequestBooking', (req, res) => {
    console.log('verify request');
    var location = {
        ID: req.body.ID,
        lat: req.body.lat,
        lng: req.body.lng,
        status: 'verify',
        usernameDriver: req.body.usernameDriver
    }

    console.log(location);

    bookingBikeRepo.updateLocationGuest(location).then(() => {
        res.statusCode = 201;
        res.json({
            msg: "verify success!"
        });
    })
    .catch(err => {
        console.log(err);
        res.end('View error log on console');
    })

    socketManager.emit('updateStatusBookingEvent', {
        ID: location.ID,
        status: location.status
    });

    socketDriver.emit('hasRequestBooking', {
        guest: location
    })
})

router.post('/book', (req, res) => {
    bookingBikeRepo.add(req.body).then(value => {
        bookingBikeRepo.loadBookingBikeById(value.insertId).then(bookingBike => {
            events.publishRequestBooking(bookingBike);
            socketManager.emit('addNewRequestBooking', bookingBike);
        })
        res.statusCode = 201;
        res.json({
            success: 1
        });
    })
        .catch(err => {
            console.log(err);
            res.statusCode = 500;
            res.json({
                success: 0
            })
            res.end('View error log on console');
        })
})

router.post('/getInfoRequestByRequestID', (req, res) => {
    bookingBikeRepo.getInfoRequestByRequestID(req.body.ID).then(value => {
        res.status = 200;
        res.json = {
            requestInfo: value[0]
        }
    }).catch(err => {
        console.log(err);
    })
})

router.post('/driverAcceptBooking', (req, res) => {

    driverRepo.getInfoDriverByDriverUsername(req.body.driverUsername).then(value => {

        console.log(value[0]);
        var bookingBike = {
            ID: req.body.ID,
            driverUsername: value[0].username,
            driverID: value[0].ID,
            status: 'hasBike'
        }

        bookingBikeRepo.driverAcceptBooking(bookingBike).then(() => {
            res.status = 200;

            socketManager.emit('updateStatusBookingEvent', {
                ID: bookingBike.ID,
                driverID: bookingBike.driverID,
                status: bookingBike.status
            });
        }).catch(err => {
            console.log(err);
            res.status = 500;
        })
    })


})

module.exports = router;