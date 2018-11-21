<template>
<div>
  <div class="navbar">
        <div class="row" style="width: 100%;">
            <div class="col-md-2">
                <img src="/static/pics/logo-desktop-white.png" width="60px;" style="margin: 0 10px 0 0;">
            </div>
            <div class="col-md-8 navTitle">
                    <img src="/static/icons/back.png" style="margin-right: 100px" v-on:click="Back()"> 
                    Đường đi ngắn nhất
            </div>
            <div class="col-md-2" style="text-align: right;">
                <div>
                    <button class="logoutBtn-r">ĐĂNG XUẤT</button>
                </div>
            </div>
        </div>
    </div>
   <div ref="map" style="width: 100%; height: 600px;"></div>
</div>
</template>

<script>
import io from "socket.io-client";
import axios from "axios";

var socket = require("socket.io-client")("http://192.168.1.11:3030");

export default {
  name: "MapRouter",
  data() {
    return {
      map: {},
      behavior: "",
      coordGuest: { lat: "", lng: "" },
      coordDriver: { lat: "", lng: "" },
      platform: {},
      View: [],
      markerGuest: "",
      markerDriver: "",
      iconGuest: "",
      iconDriver: "",
      infoBubbles: "",
      group: [],
      ui: {},
      InfoGuest: "",
      bubbleGuest: "",
      bubbleDriver: ""
    };
  },
  created() {
    this.platform = new H.service.Platform({
      app_id: "SxxR970XbZjWq11DxSea",
      app_code: "ZIgTe3WyzSsHXAsKjPBljg"
    });

    var _lat, _lng;

    var self = this;
    this.iconGuest = new H.map.Icon("/static/icons/marker-passenger.png");
    this.iconDriver = new H.map.Icon("/static/icons/marker-driver.png");

    //Information guest
    this.InfoGuest = this.$session.get("Request");

    socket.emit("getInfoDriverByDriverID", this.InfoGuest.driverID);

    //set coordinates marker guest
    this.coordGuest.lat = this.InfoGuest.guest_lat;
    this.coordGuest.lng = this.InfoGuest.guest_lng;

    //get information driver
    socket.on("connect", function() {});
    socket.on("getInfoDriverByDriverIDEvent", function(response) {
      _lat = response[0].lat;
      _lng = response[0].lng;
      self.coordDriver.lat = _lat;
      self.coordDriver.lng = _lng;
      self.markerDriver = new H.map.Marker(self.coordDriver, {
        icon: self.iconDriver
      });
      self.map.addObject(self.markerDriver);
      self.map.setCenter(self.coordDriver);

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
          var routeLine = new H.map.Polyline(linestring, {
            style: { strokeColor: "#0FA9D6", lineWidth: 10 }
          });

          // Add the route polyline and the two markers to the map:
          self.map.addObjects([routeLine, self.markerDriver, self.markerGuest]);

          // Set the map's viewport to make the whole route visible:
          self.map.setViewBounds(routeLine.getBounds());
        }

        var infoDriver =
          "<head><link href='https://fonts.googleapis.com/css?family=Montserrat:400,500,700,900' rel='stylesheet'><body></head><div style='font-family: Montserrat; padding: 10px;'><p style='font-weight: 700; font-size:14px; opacity: 0.75; text-transform: uppercase;'>Tài xế</p><span style='font-weight: 700; font-size: 12px;'>#" +
          response[0].ID +
          "</span><br>" +
          response[0].displayName +
          "</br><span style='font-size: 14px; opacity: 0.8;'>" +
          response[0].phone +
          "</span></body></div>";
        self.bubbleDriver = new H.ui.InfoBubble(self.coordDriver, {
          content: infoDriver
        });

        self.markerDriver.addEventListener(
          "pointerdown",
          function(evt) {
            self.bubbleDriver.close();
            self.bubbleDriver.open();
            // show info bubble
            self.ui.addBubble(self.bubbleDriver);
          },
          false
        );
      });
    });
  },
  mounted() {
    // Initialize the platform object:

    var defaultLayers = this.platform.createDefaultLayers();
    this.map = new H.Map(this.$refs.map, defaultLayers.normal.map, {
      zoom: 13
    });

    this.behavior = new H.mapevents.Behavior(
      new H.mapevents.MapEvents(this.map)
    );

    this.markerGuest = new H.map.Marker(this.coordGuest, {
      icon: this.iconGuest
    });

    this.map.setCenter(this.coordGuest);
    this.map.addObject(this.markerGuest);

    this.ui = new H.ui.UI.createDefault(this.map, defaultLayers);

    var infoGuest =
    "<head><link href='https://fonts.googleapis.com/css?family=Montserrat:400,500,700,900' rel='stylesheet'><body></head><div style='font-family: Montserrat; padding: 10px;'><p style='font-weight: 700; font-size:14px; opacity: 0.75; text-transform: uppercase;'>Khách</p><span style='font-weight: 700; font-size: 12px;'>#" +
          this.InfoGuest.ID +
          "</span><br>" +
          this.InfoGuest.name +
          "</br><span style='font-size: 14px; opacity: 0.8;'>" +
          this.InfoGuest.address +
          "</span></body></div>";
    this.bubbleGuest = new H.ui.InfoBubble(this.coordGuest, {
      content: infoGuest
    });

    var self = this;
    this.markerGuest.addEventListener(
      "pointerdown",
      function(evt) {
        self.bubbleGuest.close();
        self.bubbleGuest.open();
        // show info bubble
        self.ui.addBubble(self.bubbleGuest);
      },
      false
    );
  },
  methods: {
    Back() {
      this.$emit("mapRouter", false);
      this.$router.replace({ name: "Manage" });
    }
  }
};
</script>