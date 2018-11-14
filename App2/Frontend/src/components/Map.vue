<template>
  <div class="row here-map">
    <div class="col-xs-5 col-sm-5 col-md-5 col-lg-5">
          <input v-model="AddressCustomer"/>
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
      coord: { lat: "", lng: "" },
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
      var _lat, _lng, suggestAddress, urlGetAddress, urlGetAddressFromCoord;
      this.icon = new H.map.Icon("/static/icons/marker.png");
      var urlGetSuggestAddress = `http://autocomplete.geocoder.api.here.com/6.2/suggest.json?query=${
        this.AddressCustomer
      }&app_id=${this.appId}&app_code=${this.appCode}`;
      axios.get(urlGetSuggestAddress).then(result => {
        if (result.data.suggestions.length == 0) {
          alert("Không tìm thấy địa điểm");
        } else {
          suggestAddress = result.data.suggestions[0].label;
          urlGetAddress =
            "https://geocoder.api.here.com/6.2/geocode.json?app_id=SxxR970XbZjWq11DxSea&app_code=ZIgTe3WyzSsHXAsKjPBljg&searchtext=" +
            suggestAddress;

          axios
            .get(urlGetAddress)
            .then(response => {
              _lat =
                response.data.Response.View[0].Result[0].Location
                  .DisplayPosition.Latitude;
              _lng =
                response.data.Response.View[0].Result[0].Location
                  .DisplayPosition.Longitude;

              self.coord.lat = _lat;
              self.coord.lng = _lng;

              if (this.marker) {
                this.map.removeObject(this.marker);
              }
              this.marker = new H.map.Marker(self.coord, { icon: self.icon });

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
                  //get address from coordinates
                  urlGetAddressFromCoord = `https://reverse.geocoder.api.here.com/6.2/reversegeocode.json?prox=${self.coord.lat},${self.coord.lng},250&mode=retrieveAddresses&maxresults=1&gen=9&app_id=${self.appId}&app_code=${self.appCode}`;
                  axios
                    .get(urlGetAddressFromCoord)
                    .then(responseAddress => {
                     self.AddressCustomer = responseAddress.data.Response.View[0].Result[0].Location.Address.Label;
                    })
                    .catch(err => {
                      alert(err);
                    });
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
        }
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
