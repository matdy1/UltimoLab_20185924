'use strict'

var express = require('express');
var app = express();
var path = require('path');
const bodyParser = require('body-parser');

//localhost:3000/
app.get('/',function(req,res){
    res.send('Página de inicio');
});

//localhost:3000/hola
app.get('/hola', function(req,res){
    res.sendFile(path.join(__dirname + '/hola.html'));
});

//localhost:3000/hola/Carlos
app.get('/hola/:nombre', (req,res) => {
    res.send('Hola ' + req.params.nombre);
});

//localhost:3000/holas?nombre=Carlos
app.get('/holas', function (req,res) {
    res.send('Hola ' + req.query.nombre);
});

app.listen(3000,function(){
    console.log("Servidor corriendo en el puerto 3000");
});




app.post('/', bodyParser.urlencoded({extended: true}), function (req, res) {
    let nombre = req.body.nombre;
    let apellido = req.body.apellido;
    console.log(`Nombre: ${nombre}, Apellido: ${apellido}`);
    res.send(`Nombre: ${nombre}, Apellido: ${apellido}`);
});


app.listen(3000, function () {
    console.log("Servidor corriendo en el puerto 3000");
});


const mysql = require('mysql2');



let conn = mysql.createConnection({
    host: 'localhost',
    user: 'root',
    password: 'root',
    database: 'hr'
});

conn.connect(function(err){
    if(err) throw err;
    console.log("Conexión exitosa a base de datos");
});