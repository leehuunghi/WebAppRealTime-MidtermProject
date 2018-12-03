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

exports.loadAllPositionDriverReady = driverUsername => {
    var sql = `select username, lat, lng from Driver where status = 'READY' and username != '${driverUsername}'`;
    console.log(sql);
    return db.load(sql);
}

exports.getInfoDriverByDriverUsername = username => {
    var sql = `select * from Driver where username = '${username}'`;
    return db.load(sql);
}

exports.getInfoDriverByDriverID = id => {
    var sql = `select * from Driver where ID = ${id}`;
    return db.load(sql);
}

exports.updatePositionDriver = driverEntity => {
    var sql = `update Driver set lat = ${driverEntity.lat}, lng = ${driverEntity.lng} where username = '${driverEntity.username}'`;
    console.log(sql);
    return db.insert(sql);
}

exports.updateStatusDriver = driverEntity => {
    var sql = `update Driver set status = '${driverEntity.status}' where username = '${driverEntity.username}'`;
    console.log(sql);
    return db.insert(sql);
}

exports.getDriverBest = async function (locationRequest, requestID) {
    let check = false;
    let result = -1;
    for (let i = 0; i < 5000; i++) {
        if (!check) {
            await findDriverBest(locationRequest, requestID).then(value => {
                if (value != -1) {
                    check = true;
                    result = value;
                }
            });
        } else {
            return result;
        }
        //Cap nhat trang thai request khong co xe nhan
        if (i === 4999) requestRepo.updateStatusRe(requestID, 6).then(value => {
            requestRepo.getRequest(requestID).then(data => {
                events.publishRequestModified(data[0]);
            })
        })
    }
    return result;
}

