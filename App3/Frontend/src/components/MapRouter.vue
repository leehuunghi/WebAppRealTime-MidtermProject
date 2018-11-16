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
   <div ref="map" style="width: 100%; height: 520px"></div>
</div>
</template>

<script>
import io from "socket.io-client";
import axios from "axios";

var socket = require("socket.io-client")("http://172.16.1.32:3030");

export default {
  name: "MapRouter",
  data() {
    return {
      map: {},
      behavior: "",
      coordGuest: { lat: "", lng: "" },
      coordDriver: { lat: "", lng: "" },
      platform: {},
      AddressCustomer: "",
      NoteCustomer: "",
      View: [],
      markerGuest: "",
      markerDriver: "",
      iconGuest: "",
      iconDriver: "",
      // group: []
    };
  },
  props: {
    ID: String
  },
  created() {
    this.platform = new H.service.Platform({
      app_id: "SxxR970XbZjWq11DxSea",
      app_code: "ZIgTe3WyzSsHXAsKjPBljg"
    });

    var _lat, _lng;

    var self = this;
    this.iconGuest = new H.map.Icon("/static/icons/marker.png");
    this.iconDriver = new H.map.Icon("/static/icons/marker.png");

    //Information guest
    var request = this.$session.get("Request");

    socket.emit("getInfoDriverByDriverID", request.driverID);

    //set coordinates marker guest
    this.coordGuest.lat = request.guest_lat;
    this.coordGuest.lng = request.guest_lng;

    socket.on("connect", function() {});
    socket.on("getInfoDriverByDriverIDEvent", function(response) {
      _lat = response[0].lat;
      _lng = response[0].lng;
      self.coordDriver.lat = _lat;
      self.coordDriver.lng = _lng;
      self.markerDriver = new H.map.Marker(self.coordDriver, {
        icon: self.iconDriver
      });
      self.markerDriver.setData("Driver nè");
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
            style: { strokeColor: "blue", lineWidth: 10 }
          });

          // Add the route polyline and the two markers to the map:
          self.map.addObjects([routeLine, self.markerDriver, self.markerGuest]);

          // Set the map's viewport to make the whole route visible:
          self.map.setViewBounds(routeLine.getBounds());

         
        }
      });
    });
  },
  mounted() {
    // Initialize the platform object:

    var defaultLayers = this.platform.createDefaultLayers();
    this.map = new H.Map(this.$refs.map, defaultLayers.normal.map, {
      zoom: 13
    });
    // this.group = new H.map.Group();
    // this.map.addObject(this.group);

    this.behavior = new H.mapevents.Behavior(
      new H.mapevents.MapEvents(this.map)
    );

    this.markerGuest = new H.map.Marker(this.coordGuest, {
      icon: this.iconGuest
    });
    this.markerGuest.setData("User nè");

    this.map.setCenter(this.coordGuest);
    this.map.addObject(this.markerGuest);

    this.ui = new H.ui.UI.createDefault(this.map, defaultLayers);
    this.useMetricMeasurements(this.map, defaultLayers);

    //  this.group.addObject(this.markerGuest);
    //   this.group.addObject(this.markerDriver);
    //       alert(JSON.stringify(this.group));
    //       this.group.addEventListener(
    //         "tap",
    //         function(evt) {
    //           alert(1);
    //           // event target is the marker itself, group is a parent event target
    //           // for all objects that it contains
    //           var bubble = new H.ui.InfoBubble(evt.target.getPosition(), {
    //             // read custom data
    //             content: evt.target.getData()
    //           });
    //           // show info bubble
    //           this.ui.addBubble(bubble);
    //         },
    //         false
    //       );
  },
  methods: {
    Back() {
      this.$emit("mapRouter", false);
      this.$router.replace({ name: "MapRouter" });
    }
  }
};
</script>