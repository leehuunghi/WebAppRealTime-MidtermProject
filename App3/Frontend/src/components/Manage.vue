<template>
<div>
     <img src="/static/pics/backgroundapp2.png" alt="" class="cover">
    <div style="position: absolute; top: 20px; right: 20px;">
        <button class="logoutBtn">ĐĂNG XUẤT</button>
    </div>
    <div class="content blueText center" style="margin-top: -60px;">
        <div class="tit">Danh sách các request</div>
        <div class="i-am-centered" style="margin-top: 20px; margin-bottom: 50px;">
            <div class="row tableTitle" id="title">
                <div class="col-md-1">ID</div>
                <div class="col-md-2">HÀNH KHÁCH</div>
                <div class="col-md-3">ĐỊA CHỈ</div>
                <div class="col-md-2">THỜI GIAN ĐẶT</div>
                <div class="col-md-2">TRẠNG THÁI</div>
            </div>
            <ul>
            <li v-for="item in requests" :key="item.id" class="row tableRow" id="row1">
                <div class="col-md-1">#{{item.ID}}</div>
                <div class="col-md-2">{{item.name}}</div>
                <div class="col-md-3">{{item.address}}</div>
                <div class="col-md-2">{{item.time}}</div>
                <div class="col-md-2 notLocated">
                    {{item.status}}
                </div>
                <div class="col-md-1">
                    <div id="driverid" class="col-md-5" style="color: #888; cursor: pointer;">
                           {{item.driverID}}
                    </div>
                </div>
                <div class="col-md-1" v-on:click="DetailMap(item)">
                    <button class="shortestWay" style="float: right;">
                        <img src="/static/icons/shortest-way.png">
                    </button>
                </div>
            </li>
            </ul>
        </div>
    </div>

    
</div>
</template>

<script>
import io from 'socket.io-client';

var socket = require('socket.io-client')('http://172.16.1.32:3030');

export default {
    name: "Manage",
  data() {
    return {
      requests: [],
      detail: false
    };
  },
  mounted() {
    //   alert(1);
      var self = this;
      socket.on('connect', function(){});
       socket.on('loadAllRequestBookingEvent', function(data){
           self.requests = data;
       });
       socket.emit('loadAllRequestBooking', '');
  },
  methods:{
      DetailMap(item){
        this.$session.set("Request", item);
        this.$emit("mapRouter", true);
        this.$router.replace({ name: "MapRouter" });
        
      }
  }
};
</script>

