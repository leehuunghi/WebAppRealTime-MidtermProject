<template>
  <div class="row here-map">
    <div class="col-xs-5 col-sm-5 col-md-5 col-lg-5">
          <p>{{AddressCustomer}}</p>
    </div>
    <div class="col-xs-5 col-sm-5 col-md-5 col-lg-5">
          <p>{{NoteCustomer}}</p>
    </div>
     <div class="col-xs-2 col-sm-2 col-md-2 col-lg-2">
          <button>Xác nhận</button>
    </div>
    <div>
          {{coord.lat}}-{{coord.lng}}
    </div>
      <div ref="map" v-bind:style="{ width: width, height: height }" id="map"></div>
  </div>
</template>

<script>
import axios from "axios";

export default {
  name: "HereMap",
  data() {
    return {
      map: {},
      behavior: "",
      coord : { lat: "", lng: "" },
      platform: {},
      AddressCustomer: "",
      NoteCustomer: "",
      View: [], 
      marker: "", 
      icon: ""
    };
  },
  props: {
    appId: String,
    appCode: String,
    lat: String,
    lng: String,
    width: String,
    height: String
  },
  created() {
    this.platform = new H.service.Platform({
      app_id: this.appId,
      app_code: this.appCode
    });

    //reveive address data
    EventBus.$on("sendId", (id, _address, _note) => {
      this.AddressCustomer = _address;
      this.NoteCustomer = _note;
      var self = this;
      var _lat, _lng;
      this.icon = new H.map.Icon("/static/icons/marker.png");
      var url =  "https://geocoder.api.here.com/6.2/geocode.json?app_id=SxxR970XbZjWq11DxSea&app_code=ZIgTe3WyzSsHXAsKjPBljg&searchtext=" + this.AddressCustomer;
      axios
        .get(url)
        .then(result => {
          _lat.splice(0,_lat.length);
           _lng.splice(0,_lat.length);
       _lat =
            result.data.Response.View[0].Result[0].Location.DisplayPosition
              .Latitude;
       _lng =
            result.data.Response.View[0].Result[0].Location.DisplayPosition
              .Longitude;
          
          self.coord.lat = _lat;
          self.coord.lng = _lng;

          this.marker = new H.map.Marker(self.coord, { icon: icon });

          this.marker.draggable = true;
    
          this.map.addObject(this.marker);
          this.map.setCenter(self.coord);

          this.marker.addEventListener(
            "dragstart",
            function() {
              var target = ev.target;
              if (target instanceof H.map.Marker) {
                self.behavior.disable();
              }
            },
            false
          );

          this.marker.addEventListener(
            "dragend",
            function(ev) {
              var target = ev.target;
              if (target instanceof H.map.Marker) {
                self.behavior.enable();
                self.coord = target.getPosition();
              }
            },
            false
          );

          this.marker.addEventListener(
            "drag",
            function(ev) {
             
              var target = ev.target,
                pointer = ev.currentPointer;
              if (target instanceof H.map.Marker) {
                target.setPosition(
                  self.map.screenToGeo(pointer.viewportX, pointer.viewportY)
                );
              }
              
            },
            false
          );
        })
        .catch(err => {
          alert(err);
        });
    });
  },
  mounted() {
    var defaultLayers = this.platform.createDefaultLayers();

    this.map = new H.Map(this.$refs.map, defaultLayers.terrain.map, {
      zoom: 15,
      center: { lng: this.lng, lat: this.lat }
    });

    this.behavior = new H.mapevents.Behavior(
      new H.mapevents.MapEvents(this.map)
    );
    this.ui = H.ui.UI.createDefault(this.map, this.defaultLayers);
    this.useMetricMeasurements(this.map, this.defaultLayers);
  }
};
</script>

<style>
p {
  width: 80%;
  margin: 10px;
  border-style: solid;
  border-radius: 5px;
  border-color: black;
}
</style>
