var eventEmitter = require('eventemitter3');
var emitter = new eventEmitter();

var subscribeEvent = (req, res, event) => {
    res.writeHead(200, {
        'Content-Type': 'text/event-stream',
        'Cache-Control': 'no-cache',
        'Connection': 'keep-alive'
    });

    var heartBeat = setInterval(() => {
        res.write('\n');
    }, 15000);

    var handler = data => {
        var json = JSON.stringify(data);
        res.write(`retry: 500\n`);
        res.write(`event: ${event}\n`);
        res.write(`data: ${json}\n`);
        res.write(`\n`);
    }

    emitter.on(event, handler);

    req.on('close', () => {
        clearInterval(heartBeat);
        emitter.removeListener(event, handler);
    });
}

//
// event pub-sub

var REQUEST_BOOKING = 'REQUEST_BOOKING';
var STATUS_BOOKING_UPDATE = 'STATUS_BOOKING_UPDATE';

var subscribeRequestBooking = (req, res) => {
    subscribeEvent(req, res, REQUEST_BOOKING);
}

var subscribeStatusBookingUpdate = (req, res) => {
    subscribeEvent(req, res, STATUS_BOOKING_UPDATE);
}

var publishRequestBooking = requestObj => {
    emitter.emit(REQUEST_BOOKING, requestObj);
}

var publishStatusBookingUpdate = requestObj => {
    emitter.emit(STATUS_BOOKING_UPDATE, requestObj);
}

module.exports = {
    subscribeRequestBooking,
    subscribeStatusBookingUpdate,
    publishRequestBooking,
    publishStatusBookingUpdate
}