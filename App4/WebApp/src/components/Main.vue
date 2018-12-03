<template>
  <div style="height: 100%; background-color: #ccc;">
    <!--Sign-out Modal-->
    <div
      id="signoutModal"
      class="modal-backdrop"
      style="background-color: rgba(0,0,0,0.5); display: none;"
    >
      <div
        class="modal"
        role="dialog"
        style="display: block; padding-top: 200px; margin-left: 20px; margin-right: 20px;"
      >
        <div class="modal-dialog" role="document">
          <div
            class="modal-content"
            style="padding: 20px; border: none !important; border-radius: 10px;"
          >
            <div>
              <h5 class="mdTitle">Đăng xuất</h5>
            </div>
            <div class="mdDes">
              <p>Bạn muốn đăng xuất?</p>
            </div>
            <div style="text-align: right">
              <button
                id="signoutNo"
                type="button"
                class="mdBtn-no"
                v-on:click="signoutNoClick()"
              >HỦY</button>
              <button
                id="signoutYes"
                type="button"
                v-on:click="LogOut(username, map)"
                class="mdBtn"
              >ĐĂNG XUẤT</button>
            </div>
          </div>
        </div>
      </div>
    </div>

    <!--End Modal-->
    <div
      id="endModal"
      class="modal-backdrop"
      style="background-color: rgba(0,0,0,0.5); display: none;"
    >
      <div
        class="modal"
        role="dialog"
        style="display: block; padding-top: 200px; margin-left: 20px; margin-right: 20px;"
      >
        <div class="modal-dialog" role="document">
          <div
            class="modal-content"
            style="padding: 20px; border: none !important; border-radius: 10px;"
          >
            <div>
              <h5 class="mdTitle">Kết thúc</h5>
            </div>
            <div class="mdDes">
              <p>Chuyến đi đã hoàn thành?</p>
            </div>
            <div style="text-align: right">
              <button id="endNo" type="button" class="mdBtn-no" v-on:click="endModalClose()">HỦY</button>
              <button
                id="endYes"
                type="button"
                class="mdBtn"
                v-on:click="Complete(coordDriver, username, Guest)"
              >KẾT THÚC</button>
            </div>
          </div>
        </div>
      </div>
    </div>

    <!--Template Modal-->
    <div
      id="modal-template"
      class="modal-backdrop"
      style="background-color: rgba(0,0,0,0.5); display: none;"
    >
      <div
        class="modal"
        role="dialog"
        style="display: block; padding-top: 200px; margin-left: 20px; margin-right: 20px;"
      >
        <div class="modal-dialog" role="document">
          <div
            class="modal-content"
            style="padding: 20px; border: none !important; border-radius: 10px;"
          >
            <div>
              <h5 class="mdTitle">Thông báo</h5>
            </div>
            <div class="mdDes">
              <p id="modal-msg"></p>
            </div>
            <div style="text-align: right">
              <button id="close-100m" type="button" class="mdBtn" v-on:click="closeMT()">ĐÓNG</button>
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
        <span id="signoutBtn" class="logoutBtn" v-on:click="signoutBtnClick()">ĐĂNG XUẤT</span>
      </div>
      <div style="width: 45%;">
        <div
          id="readyBtn"
          class="toggleOff"
          style="float: left; border-radius: 50px 0px 0px 50px;"
          v-on:click="Ready(coordDriver, username, Guest)"
        >Ready</div>
        <div
          id="standbyBtn"
          class="toggleOn"
          style="float: left; border-radius: 0px 50px 50px 0px;"
          v-on:click="Standby(username)"
        >Standby</div>
      </div>
    </div>

    <!-- here map -->
    <div ref="map" style="width: 100%; height: 600px; position: relative" id="hereMap">
      <img
        src="/static/icons/current-location.png"
        alt
        width="40px"
        id="imgCurrent"
        style="position: absolute; z-index: 100; margin-left: 300px; margin-top:500px"
        v-on:click="CurrentLocation()"
      >
    </div>

    <!--Take-->
    <div id="take" class="notif" style="display: none;">
      <h1 class="notifTit">Yêu cầu đặt xe</h1>
      <div style="width: 100%; padding: 10px 24px 24px 24px">
        <div class="guestInfo" style="width: 100%">
          <div style="width: 80%;">
            <div>
              <div class="guestName">{{Guest.name}}</div>
              <div class="guestAdd">{{Guest.address}}</div>
            </div>
          </div>
        </div>
      </div>
      <div id="take" class="row" style="width: 100%; padding: 0px 24px; margin-left: 0px;">
        <div id="takeBtn" class="col-sm-6 col-md-6" style="width: 50%; ext-align: center;">
          <button
            id="accept"
            type="button"
            class="actionBtn take"
            v-on:click="Accept(time_out, username, Guest.ID)"
          >NHẬN</button>
        </div>
        <div class="col-sm-6 col-md-6" style="width: 50%; text-align: center;">
          <button
            type="button"
            class="actionBtn btn-danger"
            v-on:click="Refuse(time_out, Guest, username)"
          >TỪ CHỐI</button>
        </div>
      </div>
    </div>

    <div id="start" class="notif" style="display: none;">
      <h1 class="notifTit">Chuyến xe đang nhận</h1>
      <div style="width: 100%; padding: 10px 24px 24px 24px">
        <div class="guestInfo" style="width: 100%">
          <div class="guestName">{{Guest.name}}</div>
          <div class="guestAdd">{{Guest.address}}</div>
        </div>
      </div>
      <div style="width: 100%; padding: 0px 24px;">
        <button
          id="startBtn"
          v-on:click="Start(Guest)"
          type="button"
          class="actionBtn start"
        >BẮT ĐẦU</button>
      </div>
    </div>

    <!--End-->
    <div id="end" class="notif" style="display: none;">
      <h1 class="notifTit">Chuyến xe đang diễn ra</h1>
      <div style="width: 100%; padding: 10px 24px 24px 24px">
        <div class="guestInfo" style="width: 100%">
          <div class="guestName">{{Guest.name}}</div>
          <div class="guestAdd">{{Guest.address}}</div>
        </div>
      </div>
      <div style="width: 100%; padding: 0px 24px;">
        <button id="endBtn" type="button" class="actionBtn end" v-on:click="endModalOpen()">KẾT THÚC</button>
      </div>
    </div>
  </div>
</template>

<script>

import io from "socket.io-client";
import axios from "axios";
import {IPGlobal} from "../main.js";

var socket = require("socket.io-client")(`http://172.16.9.40:1412`);
socket.on("connect", function() {});

export default {
  name: "Main",
  data() {
    return {
      username: "",
      map: {},
      behavior: "",
      Guest: {},
      coordGuest: { lat: "", lng: "" },
      coordDriver: { lat: "", lng: "" },
      platform: {},
      View: [],
      markerGuest: "",
      markerDriver: "",
      iconGuest: "",
      iconDriver: "",
      ui: {},
      time_out: {},
      routeLine: null,
      isStart: false
    };
  },
  created() {
    this.platform = new H.service.Platform({
      app_id: "SxxR970XbZjWq11DxSea",
      app_code: "ZIgTe3WyzSsHXAsKjPBljg"
    });

    this.username = this.$localStorage.get("username");
    socket.emit("subcriseDriver", this.username);

    var self = this;
    this.iconGuest = new H.map.Icon("/static/icons/marker-passenger.png");
    this.iconDriver = new H.map.Icon("/static/icons/marker-driver.png");

    this.$getLocation({
      enableHighAccuracy: false, //defaults to false
      timeout: Infinity, //defaults to Infinity
      maximumAge: 0 //defaults to 0
    }).then(coordinates => {
      EventBus.$emit("DriverLocation", coordinates);
    });

    EventBus.$on("DriverLocation", coordinates => {
      if (this.map.getObjects(this.markerDriver) != null) {
        if (this.map.getObjects(this.markerDriver) != "") {
          this.map.removeObject(this.markerDriver);
        }
      }

      self.coordDriver = coordinates;
      self.markerDriver = new H.map.Marker(self.coordDriver, {
        icon: self.iconDriver
      });

      axios
        .post(
          `http://${IPGlobal.IP}:3000/api/driver/updateLocationDriver`,
          {
            lat: self.coordDriver.lat,
            lng: self.coordDriver.lng,
            username: self.username
          },
          {
            headers: {
              "Content-Type": "application/json;charset=UTF-8",
              "Access-Control-Allow-Origin": "*",
              "x-access-token": this.$localStorage.get("access_token")
            }
          }
        )
        .catch(err => {
          alert(err);
        });

      self.map.setCenter(self.coordDriver);
      self.map.addObject(self.markerDriver);
    });

    socket.on("getInfoRequestByRequestIDEvent", function(response) {
      if (response) {
        self.Guest = response[0];
        self.time_out = setTimeout(function() {
          document.getElementById("take").style.display = "none";
          document.getElementById("imgCurrent").style.marginTop = "500px";
          self.Refuse(self.time_out, self.Guest, self.username);
        }, 10000);
      }
    });

    EventBus.$on("CleanGuest", () => {
      if (this.map.getObjects(this.markerGuest) != null) {
        this.map.removeObject(this.map.getObjects(this.markerGuest));
      }

      if (this.map.getObjects(this.routeLine) != null) {
        this.map.removeObject(this.routeLine);
      }

      this.map.setCenter(this.coordDriver);
    });

    EventBus.$on("Route", msg => {
      self.coordGuest.lat = self.Guest.guest_lat;
      self.coordGuest.lng = self.Guest.guest_lng;
      if (msg == true) {
        if (self.map.getObjects(self.routeLine) != null) {
          self.map.removeObject(self.routeLine);
        }
      } else {
        self.markerGuest = new H.map.Marker(self.coordGuest, {
          icon: self.iconGuest
        });
      }
      // Create the parameters for the routing request:
      var urlGetRouteShape = `https://route.api.here.com/routing/7.2/calculateroute.json?waypoint0=${
        self.coordGuest.lat
      },${self.coordGuest.lng}&waypoint1=${self.coordDriver.lat},${
        self.coordDriver.lng
      }&mode=fastest;bicycle&routeattributes=sh&maneuverattributes=di,sh&app_id=SxxR970XbZjWq11DxSea&app_code=ZIgTe3WyzSsHXAsKjPBljg`;
      axios.get(urlGetRouteShape).then(result => {
        var route, routeShape, startPoint, endPoint, linestring;
        if (result.data.response.route) {
          // Pick the first route from the response:
          route = result.data.response.route[0];
          // Pick the route's shape:
          routeShape = route.shape;
          // Create a linestring to use as a point source for the route line
          linestring = new H.geo.LineString();
          // Push all the points in the shape into the linestring:
          routeShape.forEach(function(point) {
            var parts = point.split(",");
            linestring.pushLatLngAlt(parts[0], parts[1]);
          });
          // Create a polyline to display the route:
          self.routeLine = new H.map.Polyline(linestring, {
            style: { strokeColor: "#0FA9D6", lineWidth: 10 }
          });
          // Add the route polyline and the two markers to the map:
          self.map.addObjects([
            self.routeLine,
            self.markerDriver,
            self.markerGuest
          ]);
          // Set the map's viewport to make the whole route visible:
          self.map.setViewBounds(self.routeLine.getBounds());
        }
      });
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

    this.ui = new H.ui.UI.createDefault(this.map, defaultLayers);

    this.map.addEventListener("tap", evt => EventBus.$emit("HandleTap", evt));

    EventBus.$on("HandleTap", evt => {
      var coord = self.map.screenToGeo(
        evt.currentPointer.viewportX,
        evt.currentPointer.viewportY
      );

      var pointDriver = new H.geo.Point(
        self.coordDriver.lat,
        self.coordDriver.lng
      );
      var pointNew = new H.geo.Point(coord.lat, coord.lng);
      var distance = pointDriver.distance(pointNew);
      if (distance > 100) {
        $("#modal-msg").text("Vị trí cập nhật xa hơn 100m");
        $("#modal-template").fadeIn();
      } else {
        EventBus.$emit("DriverLocation", coord);
        if (self.Guest.ID != null) {
          EventBus.$emit("Route", true);
          var poiterGuest = new H.geo.Point(
            self.Guest.guest_lat,
            self.Guest.guest_lng
          );
          var distanceToGuest = pointNew.distance(poiterGuest);
          if (distanceToGuest < 50) {
            document.getElementById("startBtn").style.display = "block";
          }
        }
      }
    });

    //receive booking
    socket.on("hasRequestBookingEvent", function(guest) {
      if (guest.ID != null) {
        document.getElementById("take").style.display = "block";
        document.getElementById("imgCurrent").style.marginTop = "350px";
        //sent ID request to get info request
        socket.emit("getInfoRequestByRequestID", guest.ID);
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
    Ready(coordDriver, username, Guest) {
      if ($("#readyBtn").hasClass("toggleOff")) {
        $("#readyBtn").removeClass("toggleOff");
        $("#readyBtn").addClass("toggleOn");
        $("#standbyBtn").removeClass("toggleOn");
        $("#standbyBtn").addClass("toggleOff");
      }
      //notification to server
      axios.post(
        `http://${IPGlobal.IP}:3000/api/driver/updateLocationDriver`,
        {
          lat: coordDriver.lat,
          lng: coordDriver.lng,
          username: username
        },
        {
          headers: {
            "x-access-token": this.$localStorage.get("access_token")
          }
        }
      );
      axios.post(
        `http://${IPGlobal.IP}:3000/api/driver/updateStatusDriver`,
        {
          status: "READY",
          username: username
        },
        {
          headers: {
            "x-access-token": this.$localStorage.get("access_token")
          }
        }
      );

      if (Guest.ID != null) {
        EventBus.$emit("CleanGuest");
      }
    },
    Standby(username) {
      if ($("#standbyBtn").hasClass("toggleOff")) {
        $("#standbyBtn").removeClass("toggleOff");
        $("#standbyBtn").addClass("toggleOn");
        $("#readyBtn").removeClass("toggleOn");
        $("#readyBtn").addClass("toggleOff");
      }
      document.getElementById("take").style.display = "none";
      document.getElementById("imgCurrent").style.marginTop = "500px";

      //notification to server
      axios.post(
        `http://${IPGlobal.IP}:3000/api/driver/updateStatusDriver`,
        {
          status: "STANDBY",
          username: username
        },
        {
          headers: {
            "x-access-token": this.$localStorage.get("access_token")
          }
        }
      );
    },
    Accept(timeout, username, guestID) {
      document.getElementById("take").style.display = "none";
      document.getElementById("start").style.display = "block";
      document.getElementById("startBtn").style.display = "none";

      window.clearTimeout(timeout);
      EventBus.$emit("Route", false);
      axios.post(
        `http://${IPGlobal.IP}:3000/api/driver/updateStatusDriver`,
        {
          status: "BUSY",
          username: username
        },
        {
          headers: {
            "x-access-token": this.$localStorage.get("access_token")
          }
        }
      );

      var params = {
        status: "hasBike",
        ID: guestID
      };
      socket.emit("updateStatusRequestBooking", params);

      axios.post(
        `http://${IPGlobal.IP}:3000/api/bookingBike/driverAcceptBooking`,
        {
          ID: guestID,
          driverUsername: username
        },
        {
          headers: {
            "x-access-token": this.$localStorage.get("access_token")
          }
        }
      );
    },
    Refuse(timeout, Guest, username) {
      window.clearTimeout(timeout);
      document.getElementById("take").style.display = "none";

      var IDGuest = {
        ID: Guest.ID,
        lat: Guest.guest_lat,
        lng: Guest.guest_lng,
        usernameDriver: username
      };
      axios
        .post(
          `http://${IPGlobal.IP}:3000/api/bookingBike/verifyRequestBooking`,
          {
            ID: Guest.ID,
            lat: Guest.guest_lat,
            lng: Guest.guest_lng,
            usernameDriver: username
          },
          {
            headers: {
              "x-access-token": this.$localStorage.get("access_token")
            }
          }
        )
        .then(response => {
          if (response.data.msg == "verify success!") {
            $("#modal-msg").text("Đã từ chối");
            $("#modal-template").fadeIn();
          } else {
            $("#modal-msg").text("Đã xảy ra lỗi");
            $("#modal-template").fadeIn();
          }
        })
        .catch(err => {
        });
    },
    Start(Guest) {
      document.getElementById("start").style.display = "none";
      document.getElementById("end").style.display = "block";

      var params = {
        status: "moving",
        ID: Guest.ID
      };
      socket.emit("updateStatusRequestBooking", params);

      EventBus.$emit("Route", true);
    },
    endModalOpen() {
      $("#endModal").fadeIn();
    },
    Complete(coordDriver, username, Guest) {
      var params = {
        status: "complete",
        ID: Guest.ID
      };
      socket.emit("updateStatusRequestBooking", params);
      $("#endModal").fadeOut("fast");
      $("#end").hide();
      document.getElementById("imgCurrent").style.marginTop = "500px";
      document.getElementById("end").style.display = "none";
      document.getElementById("hereMap").style.display = "block";

      this.Ready(coordDriver, username, Guest);
    },
    endModalClose() {
      $("#endModal").fadeOut();
    },
    LogOut(username, map) {
      map.removeEventListener("tap", evt => EventBus.$emit("HandleTap", evt));
      $("#signoutModal").fadeOut();
      this.$localStorage.remove("access-token");
      this.$localStorage.remove("refresh-token");
      axios.post(
        `http://${IPGlobal.IP}:3000/api/driver/updateStatusDriver`,
        {
          status: "STANDBY",
          username: username
        },
        {
          headers: {
            "x-access-token": this.$localStorage.get("access_token")
          }
        }
      );
      this.$router.replace({ name: "Login" });
    },
    signoutBtnClick() {
      $("#signoutModal").fadeIn("fast");
    },
    signoutNoClick() {
      $("#signoutModal").fadeOut("fast");
    },
    endNoClick() {
      $("#endModal").fadeOut("fast");
    },
    closeMT() {
      $("#modal-template").fadeOut();
    }
  }
};
</script>



