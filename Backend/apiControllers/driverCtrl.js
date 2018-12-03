var express = require('express');

var driverRepo = require('../repos/driverRepo');

var router = express.Router();
var socketManager = require('socket.io-client')('http://localhost:3030');


router.post('/updateLocationDriver', (req, res) => {
    driverRepo.updatePositionDriver(req.body).then(() => {
        res.status = 200;
        res.json = {
            msg: 'update location driver success'
        }
        socketManager.emit('updateLocationDriver', req.body.username)
    }).catch(err => {
        res.status = 401;
        res.json = {
            msg: 'insert failed'
        }
    })
})

router.post('/updateStatusDriver', (req, res) => {
    console.log('update status driver', req.body.status);
    driverRepo.updateStatusDriver(req.body).then(() => {
        res.status = 200;
        res.json = {
            msg: 'update location driver success'
        }
        socketManager.emit('updateStatusDriverEvent', req.body.username)
    }).catch(err => {
        res.status = 401;
        res.json = {
            msg: 'insert failed'
        }
        console.log(res.json.msg);
    })
})

router.post('/getInfoDriverByDriverID', (req, res) => {
    driverRepo.getInfoDriverByDriverID(req.body.ID).then(value => {
        res.status = 200;
        res.json = {
            driverInfo: value[0]
        }
    }).catch(err => {
        console.log(err);
    })
})


module.exports = router;