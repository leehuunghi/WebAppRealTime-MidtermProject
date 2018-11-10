var http = require('http'),
    express = require('express'),
    socketIO = require('socket.io');

var router = express.Router();

var server = http.Server(express());
var io = socketIO(server);
var events = require('../event/events');

var bookingBikeRepo = require('../repos/bookingBikeRepo');

router.get('/loadAllRequestBooking', () => {
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

router.post('/book', (req, res) => {
    bookingBikeRepo.add(req.body).then(value => {
        res.statusCode = 201;
        res.json({
            success: 1
        });
        events.publishCategoryBooking(req.body);
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