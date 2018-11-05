var express = require('express'),
    bodyParser = require('body-parser'),
    cors = require('cors'),
    morgan = require('morgan');

var requestReceiverCtrl = require('./apiControllers/requestReceiverCtrl');
var employeeCtrl = require('./apiControllers/employeeCtrl');
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

app.use('/api/users/', employeeCtrl);
app.use('/api/sendRequestFromUser/', requestReceiverCtrl);

var PORT = process.env.PORT || 3000;
app.listen(PORT, () => {
    console.log(`API running on PORT ${PORT}`);
})