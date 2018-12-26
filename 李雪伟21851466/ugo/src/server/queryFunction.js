var mysql=require('mysql');

function queryVehiclelines(strCode,dealFunc){
    var conn=mysql.createConnection({
        host:'localhost',
        user:'hive',
        password:'hive',
        port:'3306',
        database:'gps',
    });

    conn.connect();

    var sql="select lng,lat from vehicle_gps where code="+JSON.stringify(strCode)+"order by gpstime; ";
    var queryData=[];
    conn.query(sql,function(err,rs){
        if(err){
            console.log(err);
            return;
        }
        var jrs=JSON.parse(rs);
        var len=jrs.length;
        for(var i=0;i<len;i++){
            queryData.push({lng:jrs[i].lng,lat:jrs[i].lat});
        }
        dealFunc(queryData);
    });

    conn.close();
}

function queryRouteCode(dealFunc){
    var conn=mysql.createConnection({
        host:'localhost',
        user:'hive',
        password:'hive',
        port:'3306',
        database:'gps',
    });

    conn.connect();

    var sql="select code from vehicle_gps group by code order by gpstime asc";
    var queryData=[];
    conn.query(sql,function(err,rs){
        if(err){
            console.log(err);
            return;
        }
        var jrs=JSON.parse(rs);
        var len=jrs.length;
        for(var i=0;i<len;i++){
            queryData.push(jrs[i].code);
        }
        dealFunc(queryData);
    });

    conn.close();
}

module.exports ={queryVehiclelines,queryRouteCode}