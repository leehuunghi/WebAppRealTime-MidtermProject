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
                <div class="col-md-1">TÀI XẾ</div>
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
                <div v-if="item.driverID != null" class="col-md-1" id="driverid" style="color: #888; cursor: pointer;" 
                        v-on:click="isShow = true,  InfoDriver(item.driverID)">
                  #{{item.driverID}}
                </div>
                <div v-if="item.driverID != null" class="col-md-1" v-on:click="DetailMap(item)">
                    <button class="shortestWay" style="float: right;">
                        <img src="/static/icons/shortest-way.png">
                    </button>
                </div>

                <!-- popup infomation driver-->
                <div v-if="isShow" id="modal" class="modal-backdrop" style="background-color: rgba(0,0,0,0.5)">
                    <div class="modal" role="dialog" style="display: block; padding-top: 200px;">
                        <div class="modal-dialog" role="document">
                            <div class="modal-content" style="padding: 20px; border: none !important; border-radius: 10px;">
                                <div>
                                    <h5 class="mdTitle">Thông tin tài xế</h5>
                                </div>
                                <div style="margin-top: 20px;">
                                    <div class="row" style="margin: 5px 5px 25px 5px;">
                                        <div class="col-md-6">
                                            <div class="mdInfo-tit">Họ tên</div>
                                            <div class="mdInfo-Cnt">{{driver.displayName}}</div>
                                        </div>
                                        <div class="col-md-6">
                                            <div class="mdInfo-tit">Số điện thoại</div>
                                            <div class="mdInfo-Cnt">{{driver.phone}}</div>
                                        </div>
                                    </div>
                                    <div class="row" style="margin: 5px;">
                                        <div class="col-md-6">
                                            <div class="mdInfo-tit">ID</div>
                                            <div class="mdInfo-Cnt">#{{driver.ID}}</div>
                                        </div>
                                        <div class="col-md-6">
                                            <div class="mdInfo-tit">Biển số xe</div>
                                            <div class="mdInfo-Cnt">{{driver.codeBike}}</div>
                                        </div>
                                    </div>
                                </div>
                                <div style="text-align: right">
                                    <button v-on:click="isShow = false" id="close" type="button" class="mdBtn">ĐÓNG</button>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </li>
            </ul>
        </div>
    </div>

    
</div>
</template>

<script>
import io from "socket.io-client";
import VueMoment from "moment";

var socket = require("socket.io-client")("http://192.168.1.10:3030");
socket.on("connect", function() {});

export default {
  name: "Manage",
  data() {
    return {
      requests: [],
      detail: false,
      isShow: false,
      driver: ""
    };
  },
  created() {
    var self = this;

    socket.on("loadAllRequestBookingEvent", function(data) {
      self.requests = data;
    });
    socket.emit("loadAllRequestBooking", "");
  },
  mounted() {
    var self = this;

    //receive information to update status
    socket.on("updateStatusBookingEvent", function(data) {
      for (let index = 0; index < self.requests.length; index++) {
        if (self.requests[index].ID == data.ID) {
          self.requests[index].status = data.status;
        }
      }
    });

    socket.on("getInfoDriverByDriverIDEvent", function(response) {
      self.driver = response[0];
    });

    //receive new request
    socket.on("addNewRequestBookingEvent", function(data) {
      self.requests.unshift(data);
    });
  },
  methods: {
    DetailMap(item) {
      this.$session.set("Request", item);
      this.$emit("mapRouter", true);
      this.$router.replace({ name: "MapRouter" });
    },
    InfoDriver(driverID) {
      socket.emit("getInfoDriverByDriverID", driverID);
    }
  },
  watch: {
    requests: {
      handler: _newRequests => {
        // _newRequests = _newRequests.reverse();
        for (let index = 0; index < _newRequests.length; index++) {
          _newRequests[index].time = VueMoment.unix(
            _newRequests[index].time
          ).format("DD/MM/YYYY HH:mm");
        }
        // alert(JSON.stringify(_newRequests));
        requests = _newRequests;
      },
      deep: true
    }
  }
};
</script>

