var mysql = require('mysql');

var connection = mysql.createConnection({
    host:'',
    port:'3306',
    user:'',
    password:'',
    database:''
});

connection.connect(function(err){
    if(err){
        console.error('Database connection failed:'+ err.stack);
        return;
    }
    console.log('Connected to database');
})