var express=require('express');
var app=express()

var codeData=require('./queryFunction')

app.post('/query',function(req,res){
    var rdata='';
    req.on('data',function(chunk){
        rdata+=chunk;
        console.log(rdata);
    });
    req.on('end',function(){
        var qInfo=JSON.parse(rdata);
        console.log(qInfo.queryContent);
        console.log(qInfo.queryTime);
        queryData('province',qInfo.queryTime,qInfo.queryContent,function(jsonData){
         res.header("Access-Control-Allow-Origin", "*");
         res.header("Access-Control-Allow-Headers", "X-Requested-With");
         res.header("Access-Control-Allow-Methods","PUT,POST,GET,DELETE,OPTIONS");
         res.header("X-Powered-By",' 3.2.1');
         res.header("Content-Type", "application/json;charset=utf-8");
         res.jsonp(jsonData);
        });
 
    });

    app.post('/test',function(req,res){
        req.on('end',function(){
            var qInfo=JSON.parse(rdata);
            console.log(qInfo.queryContent);
            console.log(qInfo.queryTime);
            queryData('province',qInfo.queryTime,qInfo.queryContent,function(jsonData){
             res.header("Access-Control-Allow-Origin", "*");
             res.header("Access-Control-Allow-Headers", "X-Requested-With");
             res.header("Access-Control-Allow-Methods","PUT,POST,GET,DELETE,OPTIONS");
             res.header("X-Powered-By",' 3.2.1');
             res.header("Content-Type", "application/json;charset=utf-8");
             res.jsonp(jsonData);
            });
     
        });
 
 });