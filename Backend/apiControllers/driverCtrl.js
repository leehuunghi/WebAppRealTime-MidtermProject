var express = require('express');

var driverRepo = require('../repos/driverRepo');

var router = express.Router();


router.post('/updateLocationDriver', (req, res) => {
    console.log(req.body);
    driverRepo.updatePositionDriver(req.body).then(() => {
        res.status = 200;
        res.json = {
            msg: 'insert success'
        }
    }).catch(err => {
        res.status = 401;
        res.json = {
            msg: 'insert failed'
        }
    })
})

router.post('/updateStatusDriver', (req, res) => {
    driverRepo.updateStatusDriver(req.body).then(() => {
        res.status = 200;
        res.json = {
            msg: 'insert success'
        }
        console.log(res.json.msg);
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