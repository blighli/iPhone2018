<template>
<div style="overflow: hidden;background-color: lightblue;">
    <div style="overflow-x:visible;overflow-y:scroll;width:1360px;position:absolute;height:90%;background-color: darkseagreen;">
        <load-more  v-if="isLoading" style="height:100px"></load-more>
        <group>
            <cell  is-link v-for="i in trainNum" :key="i" @click.native="changeIndex(i)"  link="/TicketDetail" style="background-color: darkseagreen;" >
                <cell-box slot="value" style="font-weight:bold;font-size:30px;">{{ts[i]}}</cell-box>
                <cell-box slot="title"><img src="src/assets/icons8-train-ticket-80.png" alt=""></cell-box>
            </cell>
        </group>
    </div>
</div>
</template>

<script>
import {Group,Cell,CellFormPreview,CellBox,LoadMore} from 'vux'
import EventBus from '../js/EventBus.js'
import { EventEmitter } from 'events';
import name2Code from '../js/station_name.js'
import { log } from 'util';
import { prerelease } from 'semver';

var preferance;
var url;
//var trains=[];
var totalMoney=0.0;
var totalTime=0;

var tempTrains=[];
export default {
    components:{
        Group,
        Cell,
        CellFormPreview,
        CellBox,
        LoadMore,
    },
    data(){
        return{
            buffer:preferance,
            trains:[],
            ts:[],
            isLoading:true,
            trainNum:0,
            index:0,
            seat2Price:{
                "商务座":"swz_price",
                "特等座":"tz_price",
                "一等座":"zy_price",
                "二等座":"ze_price",
                "无座":"wz_price",
            },
            seat2Num:{
                "商务座":"swz_num",
                "特等座":"tz_num",
                "一等座":"zy_num",
                "二等座":"ze_num",
                "无座":"wz_num",
            },
        }
    },
    methods:{
        getPreferance:function(){
            EventBus.$on("sendPreferance",function(val){
                preferance=JSON.parse(val);
                tempTrains=[];
            });
            console.log(preferance);
        },
        sendTrain:function(){
            var train={"trainID":this.trains[this.index].trainID,"ticket_num":this.trains[this.index].ticket_num,"ticket_price":this.trains[this.index].priceNumber,"startTime":this.trains[this.index].startTime,"endTime":this.trains[this.index].endTime,"endureTime":this.trains[this.index].endureTime,"seatType":preferance.seatType[0],"oriSite":preferance.oriSite,"desSite":preferance.desSite};
            EventBus.$emit("sendTrain",JSON.stringify(train));
        },
        changeIndex:function(i) {
            this.index=i;  
        },
        money2Number:function(str){
            var len=str.length;
            var validIndex=0;
            var ans=0.0;
            while(validIndex<len){
                var digit=str.charCodeAt(validIndex)-48;
                ans=ans*10+digit;
                validIndex++;
            }
            return ans/10;
        },
        time2Number:function(str){
            var atime=str.split(':');
            var ans=0;
            for(var i=0;i<2;i++){
                var len=atime[i].length;
                var sum=0;
                for(var j=0;j<len;j++){
                    sum=sum*10+(atime[i].charCodeAt(j)-48);
                }
                ans=ans*60+sum;
            }
            return ans;
        },
        trainSortByPriority(){
            var len=this.trains.length;
            for(var i=0;i<len;i++){
                this.trains[i].finalScore=preferance.priority*this.trains[i].lishiNumber/totalTime+(1-preferance.priority)*this.trains[i].priceNumber/totalMoney;
            }
            this.trains.sort(function(t1,t2){
                return t1.finalScore-t2.finalScore;
            })
            this.ts=[];
            for(var i=0;i<len;i++){
                this.ts.push(this.trains[i].trainID);
            }
        },
        generateURL:function(){
            var len=name2Code.length;
            var oriSiteCode="";
            var desSiteCode="";
            for(var i=0;i<len;i++){
                if(preferance["oriSite"]== name2Code[i].name){
                    oriSiteCode=name2Code[i].code;
                    break;
                }
            }
            for(var i=0;i<len;i++){
                if(preferance.desSite== name2Code[i].name){
                    desSiteCode=name2Code[i].code;
                    break;
                }
            }
            if(oriSiteCode==""||desSiteCode==""){
                return;
            }
            url="/api/leftTicketPrice/queryAllPublicPrice?leftTicketDTO.train_date="+preferance.date+"&leftTicketDTO.from_station="+oriSiteCode+"&leftTicketDTO.to_station="+desSiteCode+"&purpose_codes=ADULT";
            console.log(url);
        },
        getJSONData:function(){
            if(tempTrains.length!=0){
                this.trains=tempTrains;
                this.isLoading=false;
                this.trainNum=tempTrains.length;
                this.ts=[];
                for(var i=0;i<this.trainNum;i++){
                    this.ts.push(this.trains[i].trainID);
                }
                return;
            }
            this.$http.get(url,{credentials:true}).then(function(res){
                var josnData=JSON.parse(JSON.stringify(res.body.data));
                this.trainNum=josnData.length;
                this.trains=[];
                totalMoney=0.0;
                totalTime=0;
                this.isLoading=true;
                for(var i=0;i<this.trainNum;i++){
                    var station_train_code=josnData[i].queryLeftNewDTO["station_train_code"];
                    var start_station_telecode=josnData[i].queryLeftNewDTO["start_station_telecode"];
                    var start_station_name=josnData[i].queryLeftNewDTO["start_station_name"];
                    var end_station_telecode=josnData[i].queryLeftNewDTO["end_station_telecode"];
                    var end_station_name=josnData[i].queryLeftNewDTO["end_station_name"];
                    var start_time=josnData[i].queryLeftNewDTO["start_time"];
                    var arrive_time=josnData[i].queryLeftNewDTO["arrive_time"]
                    var lishi=josnData[i].queryLeftNewDTO["lishi"];
                    var ticket_price=josnData[i].queryLeftNewDTO[this.seat2Price[preferance.seatType]];
                    var ticket_num=josnData[i].queryLeftNewDTO[this.seat2Num[preferance.seatType]];
                    var lishiNumber=this.time2Number(lishi);
                    var priceNumber=this.money2Number(ticket_price);
                    totalTime+=lishiNumber;
                    totalMoney+=priceNumber;
                    if(ticket_num!='-1'){
                        this.trains.push({"trainID":station_train_code,"startTime":start_time,"endTime":arrive_time,"endureTime":lishi,"ticket_num":ticket_num,"ticket_price":ticket_price,"oriSite":start_station_name,"desSite":end_station_name,"seatType":preferance.seatType[0],"lishiNumber":lishiNumber,"priceNumber":priceNumber,"finalScore":0.0});
                    }
                }
                this.trainNum=this.trains.length;
                this.isLoading=false;
                this.trainSortByPriority();
                tempTrains=this.trains;

            },function(){
                console.log("query failed");
            });
        },

    },
    mounted(){
        console.log("TicketContainer mounted");
        this.getPreferance();
        this.buffer=preferance;
        this.generateURL();
        this.getJSONData();
    },
    beforeDestroy(){
        console.log("TicketContainer beforeDestroyed");
        this.sendTrain();
    },
    
}
</script>
<style>
.test{
    display:table-cell;
   background-color:mediumseagreen;
}
</style>
