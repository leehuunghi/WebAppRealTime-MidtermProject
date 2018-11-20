<template>
  <div class="here-map">

                <div class="info">
                    <div class="row">
                        <div class="col-md-6">
                            <div class="colTit">
                                Địa chỉ
                            </div>
                            <input v-model="AddressCustomer"/>
                        </div>
                        <div class="col-md-4">
                            <div class="colTit">
                                Ghi chú
                            </div>
                           
                            <p>{{NoteCustomer}}</p>
                            
                        </div>
                        <div class="col-md-2" style="text-align: right;">
                            <button class="locateBtn"  v-on:click="Located()">Định vị</button>
                        </div>
                    </div>
                </div>
         
      <div class="center" ref="map" v-bind:style="{ width: width, height: height }" id="map"></div>
  </div>
</template>

<script>
import axios from "axios";
var selfID;
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
      icon: "",
      idClick: ""
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
      this.idClick = id;

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

              this.$session.set("ID", {
                ID: id,
                lat: _lat,
                lng: _lng
              });

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
                  urlGetAddressFromCoord = `https://reverse.geocoder.api.here.com/6.2/reversegeocode.json?prox=${
                    self.coord.lat
                  },${
                    self.coord.lng
                  },250&mode=retrieveAddresses&maxresults=1&gen=9&app_id=${
                    self.appId
                  }&app_code=${self.appCode}`;
                  axios
                    .get(urlGetAddressFromCoord)
                    .then(responseAddress => {
                      self.AddressCustomer =
                        responseAddress.data.Response.View[0].Result[0].Location.Address.Label;
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
  },
  methods: {
    Located: function() {
      axios
        .post(
          "http://172.16.1.21:3000/api/bookingBike/verifyRequestBooking",
          this.$session.get("ID"),
          {
            headers: {
              "x-access-token": this.$session.get("access_token")
            }
          }
        )
        .then(response => {
          alert(JSON.stringify(response));
        })
        .catch(err => {
          alert(err);
        });
    }
  }
};
</script>

