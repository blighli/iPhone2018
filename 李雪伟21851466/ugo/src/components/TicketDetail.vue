<template>
  <div class="detail">
    <group style="background-color: darkseagreen">
      <cell title="返回" link="/Ticket" style="background-color: darkseagreen;"></cell>
      <cell title="动车号" style="background-color: darkseagreen;">
        <template>{{train.trainID}}</template>
      </cell>
      <cell title="始发地" style="background-color: darkseagreen;">
        <template>{{train.oriSite}}</template>
      </cell>
      <cell title="目的地" style="background-color: darkseagreen;">
        <template>{{train.desSite}}</template>
      </cell>
      <cell title="出发时间" style="background-color: darkseagreen;">
        <template>{{train.startTime}}</template>
      </cell>
      <cell title="到达时间" style="background-color: darkseagreen;">
        <template>{{train.endTime}}</template>
      </cell>
      <cell title="共用时间" style="background-color: darkseagreen;">
        <template>{{train.endureTime}}</template>
      </cell>
      <cell title="座位类型" style="background-color: darkseagreen;">
        <template>{{train.seatType}}</template>
      </cell>
      <cell title="剩余票数" style="background-color: darkseagreen;">
        <template>{{train.ticket_num}}</template>
      </cell>
      <cell title="花费" style="background-color: darkseagreen;">
        <template>{{train.ticket_price}}</template>
      </cell>
    </group>
  </div>
</template>

<script>
import { Group, Cell, XHeader } from "vux";
import EventBus from "../js/EventBus.js";

var t = {};
export default {
  components: {
    Group,
    Cell,
    XHeader
  },
  data() {
    return {
      train: t
    };
  },
  methods: {
    getTrain: function() {
      console.log("getTrain");
      EventBus.$on("sendTrain", function(val) {
        console.log("getTrainEvent");
        t = JSON.parse(val);
        this.train = t;
      });
      this.train = t;
    }
  },
  mounted() {
    console.log("TicketDetail mounted");
    console.log("getTrainbefore");
    this.getTrain();
    console.log("getTrain after");
  }
};
</script>

<style>
.detail {
    max-height: 500px;
    background-color: lightblue;
}
cell{
    background-color: lightblue;
}
</style>

