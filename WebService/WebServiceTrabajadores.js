const express = require('express');
const webServiceTrabajadores = require('mysql2');
const app = express();

let conn = webServiceTrabajadores.createConnection({
    host: 'localhost',
    port: 3306,
    user: 'root',
    password: 'root',
    database: 'bicicentro'

});

app.get("/trabajadores", function (req, res) {
    let sql = "select * from trabajadores";
    conn.query(sql,(err, result, fields) => {
        if(err) throw err;

        let horaActual = new Date();

        for(let i = 0; i < result.length;i++ ){
            result[i]["dni"] += ""
        }

        res.json({
            horaActual: horaActual,
            trabajadores: result
        });
    });
});

app.get("/trabajadores/:id",(req,res) => {

    let id = req.params["id"];

    let sql = "select * from bicicentro.trabajadores where dni = ?";

    conn.query(sql,[id], (err, result, fields) => {
        if(err) throw err;

        res.json(result);
    });

});

app.get("/trabajadores/ventas/:id",(req,res) => {

    let id = req.params["id"];

    let sql = "select * from bicicentro.ventas where dniTrabajador = ?";

    conn.query(sql,[id], (err, result, fields) => {
        if(err) throw err;

        res.json(result);
    });

});

app.get("/sedes", function (req, res) {
    let sql = "SELECT * FROM bicicentro.sedes";
    conn.query(sql,(err, result, fields) => {
        if(err) throw err;

        let horaActual = new Date();

        for(let i = 0; i < result.length;i++ ){
            result[i]["idsede"] += ""
        }

        res.json({
            horaActual: horaActual,
            sede: result
        });
    });
});

app.get("/sedes/:id",(req,res) => {

    let id = req.params["id"];

    let sql = "select * from bicicentro.sedes where idsede = ?";

    conn.query(sql,[id], (err, result, fields) => {
        if(err) throw err;

        res.json(result);
    });

});

app.get("/sedes/trabajadores/:id",(req,res) => {

    let id = req.params["id"];

    let sql = "select * from bicicentro.trabajadores where idsede = ?";

    conn.query(sql,[id], (err, result, fields) => {
        if(err) throw err;

        res.json(result);
    });

});


app.listen(3000,function(){
    console.log("Servidor desplegado correctamente");
});
