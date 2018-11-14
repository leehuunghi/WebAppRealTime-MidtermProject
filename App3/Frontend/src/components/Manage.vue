<template>
<div>
    <div style="position: absolute; top: 20px; right: 20px;">
        <button class="logoutBtn">ĐĂNG XUẤT</button>
    </div>
    <div class="content blueText center" style="margin-top: -60px;">
        <div class="tit">Danh sách các request</div>
        <div class="i-am-centered" style="margin-top: 20px; margin-bottom: 50px;">
            <div class="row tableTitle" id="title">
                <div class="col-md-1">ID</div>
                <div class="col-md-3">HÀNH KHÁCH</div>
                <div class="col-md-3">ĐỊA CHỈ</div>
                <div class="col-md-2">THỜI GIAN ĐẶT</div>
                <div class="col-md-3">TRẠNG THÁI</div>
            </div>
            <ul>
            <li v-for="item in requests" :key="item.id" class="row tableRow" id="row1">
                <div class="col-md-1">#{{item.ID}}</div>
                <div class="col-md-3">{{item.name}}</div>
                <div class="col-md-3">{{item.address}}</div>
                <div class="col-md-2">{{item.time}}</div>
                <div class="col-md-3 notLocated">
                    Chưa được định vị
                </div>
            </li>
            </ul>
        </div>
    </div>

    <HereMap v-if="detail"
            appId="SxxR970XbZjWq11DxSea"
            appCode="ZIgTe3WyzSsHXAsKjPBljg"
            lat="10.762622"
            lng="106.660172"
            width="100%"
            height="835px" />
</div>
</template>

<script>
import HereMap from "./MapRouter";
import io from 'socket.io-client';

var socket = require('socket.io-client')('http://192.168.1.13:3030');

export default {
  data() {
    return {
      requests: [],
      detail: false
    };
  },
  components: {
    HereMap
  },
  created() {
      var self = this;
      socket.on('connect', function(){});
       socket.on('loadAllRequestBookingEvent', function(data){
           self.requests = data;
       });
       socket.emit('loadAllRequestBooking', '');
  },
};
</script>

