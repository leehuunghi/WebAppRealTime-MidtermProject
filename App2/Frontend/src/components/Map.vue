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
      View: []
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
    EventBus.$on("sendId", id => {
      // this.AddressCustomer = String(id);
       var self = this;
      alert(id);
      this.NoteCustomer = "Cổng chính";
      this.AddressCustomer =
        "227 ĐƯỜNG Nguyễn Văn Cừ, Quận 5, Ho Chi Minh, Vietnam";

      axios
        .get(
          "https://geocoder.api.here.com/6.2/geocode.json?app_id=SxxR970XbZjWq11DxSea&app_code=ZIgTe3WyzSsHXAsKjPBljg&searchtext=227 ĐƯỜNG Nguyễn Văn Cừ, Quận 5, Ho Chi Minh, Vietnam"
        )
        .then(result => {
          var _lat =
            result.data.Response.View[0].Result[0].Location.DisplayPosition
              .Latitude;
          var _lng =
            result.data.Response.View[0].Result[0].Location.DisplayPosition
              .Longitude;
          var icon = new H.map.Icon("/static/icons/marker.png");
          self.coord.lat = _lat;
          self.coord.lng = _lng;
          // var coord = { lat: _lat, lng: _lng };
          var marker = new H.map.Marker(self.coord, { icon: icon });

          marker.draggable = true;
    
          this.map.addObject(marker);
          this.map.setCenter(self.coord);

          marker.addEventListener(
            "dragstart",
            function() {
              var target = ev.target;
              if (target instanceof H.map.Marker) {
                self.behavior.disable();
              }
            },
            false
          );

          marker.addEventListener(
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

          marker.addEventListener(
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

    this.map = new H.Map(this.$refs.map, defaultLayers.normal.map, {
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
