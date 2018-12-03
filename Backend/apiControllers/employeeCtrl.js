var express = require('express');

var employeeRepo = require('../repos/employeeRepo');
var authRepo = require('../repos/authRepo');

var router = express.Router();

router.post('/signUp', (req, res) => {
    
})



router.post('/login', (req, res) => {
    console.log(req.body);
    employeeRepo.login(req.body).then(rows => {
        if (rows.length > 0) {
            var loginEntity = rows[0];
            var acToken = authRepo.generateAccessToken(loginEntity);
            var rfToken = authRepo.generateRefreshToken();

            authRepo.updateRefreshToken(loginEntity.ID, rfToken).then(value => {
                res.json({
                    auth: 1,
                    access_token: acToken,
                    refresh_token: rfToken
                })
            })
            .catch(err => {
                console.log(err);
                res.status = 500;
                res.end('View error log on console');
            })
        } else {
            res.json({
                auth: 0,
                msg: 'tài khoản hoặc mật khẩu không đúng'
            })
        }
    })
    .catch(err => {
        console.log(err);
        res.status = 500;
        res.end('View error log on console');
    })
})

module.exports = router;