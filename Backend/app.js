var express = require('express'),
    bodyParser = require('body-parser'),
    cors = require('cors'),
    morgan = require('morgan');

var bookingBikeCtrl = require('./apiControllers/bookingBikeCtrl');
var employeeCtrl = require('./apiControllers/employeeCtrl');

var verifyAccessToken = require('./repos/authRepo').verifyAccessToken;

app = express();

app.use(morgan('dev')); 
app.use(bodyParser.json());
app.use(cors());

// app.post('/api/sendRequestFromUser/', (req, res) => {
//     console.log(req.body);
//     res.json({
//         success: 1
//     })
//     res.statusCode = 200;
// })

app.use('/api/employee/', employeeCtrl);
app.use('/api/bookingBike/', verifyAccessToken, bookingBikeCtrl);

//websocket
require('./websocket/identifyLocation_ws');

var PORT = process.env.PORT || 3000;
app.listen(PORT, () => {
    console.log(`API running on PORT ${PORT}`);
})