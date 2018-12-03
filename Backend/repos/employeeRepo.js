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
    var sql;
    if (loginEntity.role === `employee`) {
        sql = `select * from Employee where username = '${loginEntity.username}' and password = '${loginEntity.password}'`;
    } else if (loginEntity.role === `driver`) {
        sql = `select * from Driver where username = '${loginEntity.username}' and password = '${loginEntity.password}'`;
    }
    return db.load(sql);
}