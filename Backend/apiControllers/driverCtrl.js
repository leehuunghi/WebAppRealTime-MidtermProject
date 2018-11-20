var express = require('express');

var driverRepo = require('../repos/driverRepo');

var router = express.Router();


router.post('/updateLocation', (req, res) => {
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



module.exports = router;