var express = require('express');

var router = express.Router();

router.post('/', (req, res) => {
    res.status = 200;
    res.json({
        success: 1
    })
})

module.exports = router;