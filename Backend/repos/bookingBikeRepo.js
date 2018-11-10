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

exports.updateLocationGuest = location => {
    var sql = `UPDATE BookingBike SET guest_lat = ${location.lat}, guest_lng = ${location.lng} where ID = ${location.ID}`;
    return db.insert(sql);
}

exports.updateStatus = entity => {
    var sql = `update BookingBike set status = ${entity.status} where ID = ${entity.ID}`;
    return db.insert(sql);
}
