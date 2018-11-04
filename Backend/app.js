var express = require('express'),
    bodyParser = require('body-parser'),
    cors = require('cors'),
    morgan = require('morgan');

    app = express();

    app.use(morgan('dev'));
    app.use(bodyParser.json());
    app.use(cors());

    var PORT = process.env.PORT || 3000;
    app.listen(PORT, () => {
        console.log(`API running on PORT ${PORT}`);
    })