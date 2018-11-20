var express = require('express');

var db = require('../fn/mysql-db');

// exports.add = driverEntity => {
//     var sql = `insert into Driver(name, phone, note, address) values('${driverEntity.name}', '${driverEntity.phone}', '${driverEntity.note}', '${driverEntity.address}')`;
//     return db.insert(sql);
// }

// exports.loadAll = () => {
//     var sql = `select * from Driver`;
//     return db.load(sql);
// }

// exports.updateLocationGuest = location => {
//     var sql = `UPDATE Driver SET guest_lat = ${location.lat}, guest_lng = ${location.lng} where ID = ${location.ID}`;
//     return db.insert(sql);
// }

// exports.updateStatus = entity => {
//     var sql = `update Driver set status = ${entity.status} where ID = ${entity.ID}`;
//     return db.insert(sql);
// }

exports.loadAllPositionDriverReady = driverEntity => {
    var sql = `select ID, lat, lng from Driver where status = 'READY'`;
    return db.load(sql);
}

exports.getInfoDriverByDriverID = id => {
    var sql = `select * from Driver where ID = ${id}`;
    return db.load(sql);
}

exports.updatePositionDriver = driverEntity => {
    var sql = `update Driver set lat = ${driverEntity.lat}, lng = ${driverEntity.lng} where username = ${driverEntity.username}`;
    return db.insert(sql);
}
