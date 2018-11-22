<template>
    <div style="height: 100%; background-color: #ccc;">
           <!--Sign-out Modal-->
        <div id="signoutModal" class="modal-backdrop" style="background-color: rgba(0,0,0,0.5); display: none;">
            <div class="modal" role="dialog" style="display: block; padding-top: 200px; margin-left: 20px; margin-right: 20px;">
                <div class="modal-dialog" role="document">
                    <div class="modal-content" style="padding: 20px; border: none !important; border-radius: 10px;">
                        <div>
                            <h5 class="mdTitle">Đăng xuất</h5>
                        </div>
                        <div class="mdDes">
                            <p>Bạn muốn đăng xuất?</p>
                        </div>
                        <div style="text-align: right">
                            <button id="signoutNo" type="button" class="mdBtn-no">HỦY</button>
                            <button id="signoutYes" type="button" class="mdBtn">ĐĂNG XUẤT</button>
                        </div>
                    </div>
                </div>
        </div>
    </div>

    
    <!--End Modal-->
    <div id="endModal" class="modal-backdrop" style="background-color: rgba(0,0,0,0.5); display: none;">
        <div class="modal" role="dialog" style="display: block; padding-top: 200px; margin-left: 20px; margin-right: 20px;">
            <div class="modal-dialog" role="document">
                <div class="modal-content" style="padding: 20px; border: none !important; border-radius: 10px;">
                    <div>
                        <h5 class="mdTitle">Kết thúc</h5>
                    </div>
                    <div class="mdDes">
                        <p>Chuyến đi đã hoàn thành?</p>
                    </div>
                    <div style="text-align: right">
                        <button id="endNo" type="button" class="mdBtn-no">HỦY</button>
                        <button id="endYes" type="button" class="mdBtn">KẾT THÚC</button>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <div class="navbar">
        <div style="width: 15%">
            <img src="/static/pics/logo-mobile-white.png" width="37.5px">
        </div>
        <div style="width: 40%;">
            <span id="signoutBtn" class="logoutBtn">ĐĂNG XUẤT</span>
        </div>
        <div style="width: 45%;">
            <div id="readyBtn" class="toggleOff" style="float: left; border-radius: 50px 0px 0px 50px;" 
            v-on:click ="Ready">
                Ready
            </div>
            <div id="standbyBtn" class="toggleOn" style="float: left; border-radius: 0px 50px 50px 0px;"
            v-on:click ="Standby">
                Standby
            </div>
        </div>
    </div>
    
    <!-- here map -->
    <div ref="map" style="width: 100%; height: 600px; position: relative" id="hereMap">
        <img src="/static/icons/current-location.png" alt="" width="50px" id="imgCurrent"
            style="position: absolute; z-index: 100; margin-left: 300px; margin-top:500px" v-on:click="CurrentLocation">
    </div>

    

    <!--Take-->
    <div id="take" class="notif" style="display: none;">
        <h1 class="notifTit">Yêu cầu đặt xe</h1>
        <h1 class="notifTitDes">Bạn có một yêu cầu đặt xe</h1>
        <div style="width: 100%; padding: 10px 24px 24px 24px">
            <div class="guestInfo" style="width: 100%">
                <div style="width: 80%;">
                    <div>
                        <div class="guestName">Nguyễn Văn A</div>
                        <div class="guestAdd">215C Trương Công Định, phường 7, Q.Tân Bình</div>
                    </div>
                </div>
                <div style="float: right; width: 20%; text-align: right; margin-top: -40px;">
                    <button type="button" id="phoneBtn" class="phoneBtn"><img src="/static/pics/phone.png" width="15px"></button>
                </div>
            </div>
        </div>
        <div class="row" style="width: 100%; padding: 0px 24px;">
            <div class="col-sm-6 col-md-6"> 
                <button id="takeBtn" type="button" class="actionBtn take" v-on:click="Accept">NHẬN</button> 
            </div>
            <div class="col-sm-6 col-md-6"> 
               <button id="takeBtn" type="button" class="actionBtn btn-danger" v-on:click="Refuse">TỪ CHỐI</button> 
            </div>
        </div>
    </div>

    <div id="start" class="notif" style="display: none;">
        <h1 class="notifTit">Chuyến xe đang nhận</h1>
        <div style="width: 100%; padding: 10px 24px 24px 24px">
            <div class="guestInfo" style="width: 100%">
                <div class="guestName">Nguyễn Văn A</div>
                <div class="guestAdd">215C Trương Công Định, phường 7, Q.Tân Bình</div>
            </div>
        </div>
        <div style="width: 100%; padding: 0px 24px;">
            <button id="startBtn" type="button" class="actionBtn start">BẮT ĐẦU</button>
        </div>
    </div>

    <!--End-->
    <div id="end" class="notif" style="display: none;">
        <h1 class="notifTit">Chuyến xe đang nhận</h1>
        <div style="width: 100%; padding: 10px 24px 24px 24px">
            <div class="guestInfo" style="width: 100%">
                <div class="guestName">Nguyễn Văn A</div>
                <div class="guestAdd">215C Trương Công Định, phường 7, Q.Tân Bình</div>
            </div>
        </div>
        <div style="width: 100%; padding: 0px 24px;">
            <button id="endBtn" type="button" class="actionBtn end">KẾT THÚC</button>
        </div>
    </div>

    </div>
</template>

<script>
$(document).ready(function() {
  $("#signoutBtn").click(function() {
    $("#signoutModal").fadeIn("fast");
  });

  $("#endBtn").click(function() {
    $("#endModal").fadeIn("fast");
  });

  $("#signoutYes").click(function() {
    $("#signoutModal").fadeOut("fast");
  });

  $("#signoutNo").click(function() {
    $("#signoutModal").fadeOut("fast");
  });

  $("#endYes").click(function() {
    $("#endModal").fadeOut("fast");
    $("#end").hide();
  });

  $("#endNo").click(function() {
    $("#endModal").fadeOut("fast");
  });

  $("#takeBtn").click(function() {
    $("#take").hide();
    $("#start").show();
  });

  $("#startBtn").click(function() {
    $("#start").hide();
    $("#end").show();
  });

  $("#readyBtn").click(function() {
    if ($("#readyBtn").hasClass("toggleOff")) {
      $("#readyBtn").removeClass("toggleOff");
      $("#readyBtn").addClass("toggleOn");
      $("#standbyBtn").removeClass("toggleOn");
      $("#standbyBtn").addClass("toggleOff");
    }
  });

  $("#standbyBtn").click(function() {
    if ($("#standbyBtn").hasClass("toggleOff")) {
      $("#standbyBtn").removeClass("toggleOff");
      $("#standbyBtn").addClass("toggleOn");
      $("#readyBtn").removeClass("toggleOn");
      $("#readyBtn").addClass("toggleOff");
    }
  });
});

import io from "socket.io-client";
import axios from "axios";

// var socket = require("socket.io-client")("http://172.16.9.218:3030");
export default {
  name: "Main",
  data() {
    return {
      map: {},
      behavior: "",
      coordGuest: { lat: "", lng: "" },
      coordDriver: { lat: "", lng: "" },
      pointDriver: "",
      platform: {},
      View: [],
      markerGuest: "",
      markerDriver: "",
      iconGuest: "",
      iconDriver: "",
      ui: {}
    };
  },
  created() {
    this.platform = new H.service.Platform({
      app_id: "SxxR970XbZjWq11DxSea",
      app_code: "ZIgTe3WyzSsHXAsKjPBljg"
    });

    var self = this;
    // this.iconGuest = new H.map.Icon("/static/icons/marker-passenger.png");
    this.iconDriver = new H.map.Icon("/static/icons/marker-driver.png");

    this.$getLocation({
      enableHighAccuracy: false, //defaults to false
      timeout: Infinity, //defaults to Infinity
      maximumAge: 0 //defaults to 0
    }).then(coordinates => {
      this.pointDriver = new H.geo.Point(
        coordinates.lat,
        coordinates.lng
      );
      EventBus.$emit("DriverLocation", coordinates);
    });

    EventBus.$on("DriverLocation", coordinates => {
      if (this.map.getObjects(this.markerDriver) != null) {
        this.map.removeObject(this.markerDriver);
      }

      self.coordDriver = coordinates;
      self.markerDriver = new H.map.Marker(self.coordDriver, {
        icon: self.iconDriver
      });
      self.map.addObject(self.markerDriver);
      self.map.setCenter(self.coordDriver);
    });
  },
  mounted() {
    // Initialize the platform object:
    var defaultLayers = this.platform.createDefaultLayers();
    var self = this;
    this.map = new H.Map(this.$refs.map, defaultLayers.normal.map, {
      zoom: 20
    });

    this.behavior = new H.mapevents.Behavior(
      new H.mapevents.MapEvents(this.map)
    );
    this.markerDriver = new H.map.Marker(this.coordDriver, {
      icon: this.iconDriver
    });
    this.map.setCenter(this.coordDriver);
    this.map.addObject(this.markerDriver);
    this.ui = new H.ui.UI.createDefault(this.map, defaultLayers);

    this.map.addEventListener("tap", function(evt) {
      var coord = self.map.screenToGeo(
        evt.currentPointer.viewportX,
        evt.currentPointer.viewportY
      );

      var pointNew = new H.geo.Point(coord.lat, coord.lng);
      var distance = self.pointDriver.distance(pointNew);
      if (distance > 100) alert("Vị trí được cập nhật xa hơn 100m");
      else {
        EventBus.$emit("DriverLocation", coord);
      }
    });
  },
  methods: {
    CurrentLocation() {
      this.$getLocation({
        enableHighAccuracy: false, //defaults to false
        timeout: Infinity, //defaults to Infinity
        maximumAge: 0 //defaults to 0
      }).then(coordinates => {
        EventBus.$emit("DriverLocation", coordinates);
      });
    },
    Ready() {
      document.getElementById("take").style.display = "block";
      document.getElementById("imgCurrent").style.marginTop = "200px";
      // document.getElementById("hereMap").style.height= 400 + "px";

      //notification to server
    },
    Standby() {
      document.getElementById("take").style.display = "none";
      document.getElementById("imgCurrent").style.marginTop = "500px";
      // document.getElementById("hereMap").style.height = 600 + "px";

      //notification to server
    }
  }
};
</script>
