<template>
    <div class="preferance-container">
        <flexbox style="background-color: darkseagreen;">
            <flexbox-item :span="1/24"></flexbox-item>
            <flexbox-item :span="1/24">始发地</flexbox-item>
            <flexbox-item :span="1/3">
                <search :results="sites" v-model="oriSite" @on-result-click="selectOriSite" @on-change="displaySiteLike(oriSite)">
                </search>
            </flexbox-item>
            <flexbox-item :span="1/20"></flexbox-item>
            <flexbox-item :span="1/10"><img src="../assets/icons8-data-transfer-80.png"></flexbox-item>
            <flexbox-item :span="1/24">目的地</flexbox-item>
            <flexbox-item :span="1/3">
                <search :results="sites" v-model="desSite" @on-result-click="selectDesSite" @on-change="displaySiteLike(desSite)">
                </search>
            </flexbox-item>
        </flexbox>
        <group>
            <datetime v-model="date" title="出发日期"  style="background-color: darkseagreen;height:65px;">
            </datetime>
        </group>
        <group>
            <popup-picker title="座位类别" :data="seatTypes" v-model="seatType"  style="background-color: darkseagreen;height:75px">
            </popup-picker>
        </group>
        <br>
        <flexbox  style="background-color: darkseagreen;height: 100px;">
            <flexbox-item :spab="1/8"></flexbox-item>
            <flexbox-item :span="1/16">时间：{{priority}}</flexbox-item>
            <flexbox-item :span="3/4">
                <cell  primary="content" style="height:30%">
                    <range v-model="priority"></range>
                </cell>
            </flexbox-item>
            <flexbox-item :span="1/8">金额：{{100-priority}}</flexbox-item>
        </flexbox>
    </div>

</template>

<script>
import {Group,Datetime,PopupPicker,Search,Cell,Range,Flexbox,FlexboxItem} from 'vux'
import EventBus from '../js/EventBus.js'
import name2Code from '../js/station_name.js'



var preferance;
var today=new Date();
export default {
    components:{
        Group,
        Datetime,
        PopupPicker,
        Search,
        Cell,
        Range,
        Flexbox,
        FlexboxItem,
    },
    data(){
        return{
            date: today.toISOString().substring(0,10),
            seatType:['二等座'],
            seatCode:7,
            oriSite:'莆田',
            desSite:'宁波',
            priority:1,
            sites:[{title:'北京',other:'BJP'},{title:'莆田',other:'PTT'}],
            seatTypes:[['商务座','一等座','二等座','无座'],],
            seatCodes:[5,6,7,14],
        }
    },
    watch:{
        date:function(){
        }
    },
    methods:{
        selectOriSite:function(item){
            this.oriSite=item.title;
        },
        selectDesSite:function(item){
            this.desSite=item.title;
        },
        displaySiteLike:function(str){
            if(str==""){
                return;
            }
            this.sites=[];
            var matchStr=new RegExp(str);
            for(var i=0;i<name2Code.length;i++){
                if(matchStr.test(name2Code[i].name)){
                    this.sites.push({"title":name2Code[i].name,"other":name2Code[i].code});
                }
            }
        },

        sendPreferance:function(){
            preferance=JSON.stringify({"date":this.date,"seatType":this.seatType,"oriSite":this.oriSite,"desSite":this.desSite,"priority":this.priority});
            EventBus.$emit("sendPreferance",preferance);
        }
    },
    beforeDestroy(){
        console.log("Preferance before destroy");
        this.sendPreferance();
    },
    mounted(){
        if(preferance){
            console.log('yes');
            preferance=JSON.parse(preferance);
            this.oriSite=preferance.oriSite;
            this.desSite=preferance.desSite;
            this.priority=preferance.priority;
            this.date=preferance.date;
            this.seatType=preferance.seatType;
        }
    },
}
</script>
<style>
.preferance-container{

}
</style>


