<template>
<div>
  <!-- popup infomation driver-->
     <div v-if="isShow" id="modal" class="modal-backdrop" style="height: 100%; width: 100%;">
                    <div class="modal" role="dialog" style="display: block; padding-top: 150px; background-color: rgba(0,0,0,0.5);">
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
     <!-- <img src="/static/pics/backgroundapp2.png" alt="" class="cover">
     <div style="position: absolute; top: 20px; right: 20px;" v-on:click="LogOut()">
        <button class="logoutBtn">ĐĂNG XUẤT</button>
    </div> -->

    <div class="navbar" id="navbar" style="position: fixed; width: 100%; z-index: 99999; opacity: 0;">
        <div class="row" style="width: 100%; margin: 0px;">
            <div class="col-md-2">
                <img src="/static/icons/logo-desktop-white.png" width="60px;" style="margin: 0 10px 0 0;">
            </div>
            <div class="col-md-8 navTitle">
                Danh sách các request
            </div>
            <div class="col-md-2" style="text-align: right; padding-right: 0px;"  v-on:click="LogOut()">
                <div>
                    <button class="logoutBtn-r">ĐĂNG XUẤT</button>
                </div>
            </div>
        </div>
    </div>
    <div class="coverBg" style="z-index: -99;">
        <div id="logoutBtn" style="position: fixed; width: 100%; text-align: right; z-index: 99;"  v-on:click="LogOut()">
            <button class="logoutBtn">Đăng xuất</button>
        </div>
        <img id="cover" src="/static/pics/cover-manager.png" style="width: 100%; height: auto; opacity: 1; margin-bottom: 0px;">
    </div>


    <div class="content blueText center" style="margin-top: -40px; z-index: 9999;">
        <div id="tit" class="tit">Danh sách các request</div>
        <div class="i-am-centered" style="margin-top: 20px; margin-bottom: 50px;">
            <ul>
            <li class="row tableTitle" id="title">
                <div class="col-md-1">ID</div>
                <div class="col-md-2">HÀNH KHÁCH</div>
                <div class="col-md-3">ĐỊA CHỈ</div>
                <div class="col-md-2">THỜI GIAN ĐẶT</div>
                <div class="col-md-2">TRẠNG THÁI</div>
                <div class="col-md-1">TÀI XẾ</div>
                <div class="col-md-1"></div>
            </li>
            </ul>
            <ul>
            <li v-for="item in requests" :key="item.id" class="row tableRow" id="row1">
                <div class="col-md-1">#{{item.ID}}</div>
                <div class="col-md-2">{{item.name}}</div>
                <div class="col-md-3">{{item.address}}</div>
                <div class="col-md-2">{{item.time}}</div>
                <div class="col-md-2">
                   <div v-if="item.status === 'verify'" style="color: #0094FF">Đã định vị xong</div>
                   <div v-if="item.status === 'hasBike'" style="color: #FFA500 ">Đã có xe nhận</div>
                   <div v-if="item.status === 'moving'"  style="color: #FF0000 ">Đang di chuyển</div>
                   <div v-if="item.status === 'complete'" style="color: #15CE1C">Đã hoàn thành</div>
                   <div v-if="item.status === 'waiting'" style="color: #696969 ">Chưa được định vị</div>


                </div>
                <div v-if="item.driverID != null" class="col-md-1" id="driverid" style="color: #888; cursor: pointer;" 
                        v-on:click="isShow = true,  InfoDriver(item.driverID)">
                  <span class="driverIDBtn">#{{item.driverID}}</span>
                </div>
                <div v-if="item.driverID != null" class="col-md-1" v-on:click="DetailMap(item)">
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

$(document).ready(function(){
  $(window).on('scroll', function () {
            var st = $(this).scrollTop();
            $("#cover").css({
                'opacity': 1 - st / 350
            });
            $('#navbar').css({
                'opacity': 0 + (st - 300) / 50
            });
            $("#content").css(
                'margin', '-' + (-20 - st / 350) + 'px 0px 0px 0px'
            );
            $("#tit").css({
              'margin-top': -40 + st/100
            });
            $("#tit").css({
              'margin-bottom': st/100
            })
        });
})

import io from "socket.io-client";
import VueMoment from "moment";
import axios from "axios";

var socket = require("socket.io-client")("http://172.16.8.51:3030");
socket.on("connect", function() {});

export default {
  name: "Manage",
  data() {
    return {
      requests: [],
      isShow: false,
      driver: ""
    };
  },
  created() {
    var self = this;
    var access_token = this.$localStorage.get("access_token");
    axios
      .get("http://172.16.8.51:3000/api/bookingBike/loadAllRequestBooking", {
        headers: {
          "x-access-token": access_token
        }
      })
      .then(data => {
        for (
          let index = 0;
          index < data.data.listRequestBooking.length;
          index++
        ) {
          var item = data.data.listRequestBooking[index];
          data.data.listRequestBooking[index].time = VueMoment.unix(
            item.time
          ).format("DD/MM/YYYY HH:mm");
        }
        self.requests = data.data.listRequestBooking;
      })
      .catch(err => {
        alert(err);
      });
  },
  mounted() {
    var self = this;

    //receive information to update status
    socket.on("updateStatusBookingEvent", function(data) {

      for (let index = 0; index < self.requests.length; index++) {
        if (self.requests[index].ID == data.ID) {
          self.requests[index].status = data.status;
          self.requests[index].driverID = data.driverID;
        }
      }
    });

    socket.on("getInfoDriverByDriverIDEvent", function(response) {
      self.driver = response[0];
    });

    //receive new request
    socket.on("addNewRequestBookingEvent", function(data) {
      data.time = VueMoment.unix(data.time).format("DD/MM/YYYY HH:mm");
      self.requests.unshift(data);
    });
  },
  methods: {
    DetailMap(item) {
      this.$session.set("Request", item);
      this.$router.replace({ name: "MapRouter" });
    },
    InfoDriver(driverID) {
      socket.emit("getInfoDriverByDriverID", driverID);
    },
    LogOut() {
      this.$localStorage.remove("access-token");
      this.$localStorage.remove("refresh-token");
      this.$router.replace({ name: "FormLogin" });
    }
  },
  watch: {
    requests: _newRequests => {
      this.requests = _newRequests;
    }
  }
};
</script>

