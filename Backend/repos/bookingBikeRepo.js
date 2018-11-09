var express = require('express');

var db = require('../fn/mysql-db');

exports.add = bookingBikeEntity => {
    var sql = `insert into BookingBike(name, phone, note, address) values('${bookingBikeEntity.name}', '${bookingBikeEntity.phone}', '${bookingBikeEntity.note}', '${bookingBikeEntity.address}')`;
    return db.insert(sql);
}

exports.loadAll = () => {
    var sql = `select * from BookingBike`;
    return db.load(sql);
}
