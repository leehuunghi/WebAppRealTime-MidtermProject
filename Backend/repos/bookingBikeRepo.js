var express = require('express');
var moment = require('moment')
var db = require('../fn/mysql-db');

exports.add = bookingBikeEntity => {
    var sql = `insert into BookingBike(name, phone, note, address, time) values('${bookingBikeEntity.name}', '${bookingBikeEntity.phone}', '${bookingBikeEntity.note}', '${bookingBikeEntity.address}', '${moment().unix()}')`;
    return db.insert(sql);
}

exports.loadAllRequestBookingWaiting = () => {
    var sql = `select * from BookingBike where status = 'waiting' order by ID DESC`;
    return db.load(sql);
}

exports.loadAll = () => {
    var sql = `select * from BookingBike order by ID DESC`;
    return db.load(sql);
}

exports.lastInsertId = () => {
    var sql = `SELECT LAST_INSERT_ID()`;
    return db.load(sql);
}

exports.updateStatusBooking = object => {
    var sql = `UPDATE BookingBike SET status = ${object.status} where ID = ${object.ID}`;
    return db.load(sql);
}

exports.updateLocationGuest = location => {
    var sql = `UPDATE BookingBike SET guest_lat = ${location.lat}, guest_lng = ${location.lng}, status = '${location.status}' where ID = ${location.ID}`;
    return db.load(sql);
}

exports.loadBookingBikeById = id => {
    var sql = `select * from BookingBike where ID = ${id}`;
    return db.load(sql);
}

exports.updateStatusDriver = object => {
    var sql = `update Driver set status = ${object.status} where ID = ${object.ID}`;
    return db.load(sql);
}