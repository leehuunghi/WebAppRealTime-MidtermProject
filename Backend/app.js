var express = require('express'),
    bodyParser = require('body-parser'),
    cors = require('cors'),
    morgan = require('morgan');

var bookingBikeCtrl = require('./apiControllers/bookingBikeCtrl');
var employeeCtrl = require('./apiControllers/employeeCtrl');
var driverCtrl = require('./apiControllers/driverCtrl')

var verifyAccessToken = require('./repos/authRepo').verifyAccessToken;
var updateAccessToken = require('./repos/authRepo').updateAccessToken;
var events = require('./event/events');
app = express();

app.use(morgan('dev'));
app.use(bodyParser.json());
app.use(cors());

// app.post('/', (req, res) => {
//     console.log(req.body);
//     res.json({
//         success: 1
//     })
//     res.statusCode = 200;
// })
app.post('/api/me', verifyAccessToken, (req, res) => {
    res.json({
        auth: 1
    })
})

app.post('/api/updateAccessToken', (req, res) => {
    updateAccessToken(req.body.refresh_token).then(token => {
        console.log("token" + token);
        res.status = 200;
        res.json = {
            access_token: token
        }
    }).catch(err => {
        res.status = 401;
        res.json = {
            access_token: "",
            msg: "wrong refresh token"
        }
    })
})

app.get('/api/a/', events.subscribeRequestBooking);
app.use('/api/employee/', employeeCtrl);
app.use('/api/bookingBike/', verifyAccessToken, bookingBikeCtrl);
app.use('/api/driver/', driverCtrl);


//websocket
require('./websocket/identifyLocation_ws');
require('./websocket/driver_ws');

var PORT = process.env.PORT || 3000;
app.listen(PORT, () => {
    console.log(`API running on PORT ${PORT}`);
})