var http = require('http'),
    express = require('express');
var router = express.Router();
var moment = require('moment');
var haversine = require('haversine');

var events = require('../event/events');
var socket = require('socket.io-client')('http://localhost:3030');
var socketDriver = require('socket.io-client')('http://localhost:1412');

var bookingBikeRepo = require('../repos/bookingBikeRepo');


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
    var location = {
        ID: req.body.ID,
        lat: req.body.lat,
        lng: req.body.lng,
        status: 'verify'
    }
    socket.emit('updateStatusBookingEvent', {
        ID: location.ID,
        status: location.status
    });

    socketDriver.emit('hasRequestBooking', {
        guest: location
    })

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
})

router.post('/book', (req, res) => {
    bookingBikeRepo.add(req.body).then(value => {
        bookingBikeRepo.loadBookingBikeById(value.insertId).then(bookingBike => {
            events.publishRequestBooking(bookingBike);
            socket.emit('addNewRequestBooking', bookingBike);
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

module.exports = router;