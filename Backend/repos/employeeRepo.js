var md5 = require('crypto-js/md5');

var db = require('../fn/mysql-db');

exports.addDriver = driverEntity => {

    var md5_pwd = md5(employeeEntity.password);
    var sql = `insert into Driver(username, password, phone) values('${driverEntity.Username}', '${md5_pwd}', ${driverEntity.phone})`;

    return db.insert(sql);
}

exports.login = loginEntity => {
    // loginEntity {
    //     username
    //     password
    //     role
    // }

    var md5_pwd = md5(loginEntity.password);
    if (loginEntity.role === `employee`) {
        var sql = `select * from Employee where username = '${loginEntity.Username} and password = '${md5_pwd}`;
    } else if (loginEntity.role === `driver`) {
        var sql = `select * from Driver where username = '${loginEntity.Username} and password = '${md5_pwd}`;
    }
    return db.load(sql);
}