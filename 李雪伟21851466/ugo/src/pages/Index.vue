<template>
    <div class="page">
        <div>
        <router-view></router-view>
        </div>
        <tabbar class="navbar">
            <TabbarItem  link="/Prefer" style="background-color:olivedrab;border-radius:10px;">
                <img slot="icon" src="../assets/icons8-heart-outline-80.png">
                <span slot="label">偏好</span>
            </TabbarItem>
            <TabbarItem selected link="/Ticket" style="background-color:olivedrab;border-radius:10px;">
                <img slot="icon" src="../assets/icons8-train-80.png">
                <span slot="label">车票</span>
            </TabbarItem>
        </tabbar>
        </div>
</template>

<script>
import {Tabbar,TabbarItem,TransferDom,ViewBox} from 'vux'

export default {
    directives:{
        TransferDom,
    },
    components:{
        Tabbar,
        TabbarItem,
        ViewBox,
    },
    data(){
        return{
            
        }
    }
}
</script>
<style>
.page{
    overflow-x:hidden;
}
.navbar{
    position:fixed;
    margin-bottom: 0px;
    background-color:steelblue;
    width: 1000px;
}
</style>

