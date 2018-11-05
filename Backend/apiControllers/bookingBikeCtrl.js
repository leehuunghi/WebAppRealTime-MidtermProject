var express = require('express');

var router = express.Router();

router.post('/', (req, res) => {
    //success 1 - 0
    res.status = 200;
    res.json({
        success: 1
    })
    console.log(req.body);
})

module.exports = router;