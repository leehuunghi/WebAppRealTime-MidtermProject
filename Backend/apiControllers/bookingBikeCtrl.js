var http = require('http'),
    express = require('express'),
    socketIO = require('socket.io');

var router = express.Router();

var server = http.Server(express());
var io = socketIO(server);

var bookingBikeRepo = require('../repos/bookingBikeRepo');

io.on('connection', socket => {
    console.log('a user connected');

    socket.on('load-all-request', () => {
        bookingBikeRepo.loadAll().then(values => {
            socket.emit('server-send-all-request', values);
        }
    )
})


    socket.on('disconnect', () => {
        console.log('user disconnected');
    });

    socket.on('chat', msg => {
        // console.log(`message: ${msg}`);
        io.emit('chat', msg);
    });
});

router.post('/book', (req, res) => {
    bookingBikeRepo.add(req.body).then(value => {
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