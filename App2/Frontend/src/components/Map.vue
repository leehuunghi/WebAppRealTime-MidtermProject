<template>
  <div class="here-map">

                <div class="info">
                    <div class="row">
                        <div class="col-md-6">
                            <div class="colTit">
                                Địa chỉ
                            </div>
                            <input type="text" v-model="AddressCustomer" v-on:keyup="keymonitor" id="address">
                            <div id="listAddressSuggest">
                                <div v-for="item in suggests" :key="item.id">
                                
                                  <div v-on:click="ChangeAddress(item.label)">{{item.label}}</div>      
                                  
                                </div>
                            </div>
                        </div>
                        <div class="col-md-4">
                            <div class="colTit">
                                Ghi chú
                            </div>
                           
                            <p id="note">{{NoteCustomer}}</p>
                            
                        </div>
                        <div class="col-md-2" style="text-align: right;">
                            <button class="locateBtn"  v-on:click="Located(IDCustomer)">Định vị</button>
                        </div>
                    </div>
                </div>
         
      <div class="center" ref="map" v-bind:style="{ width: width, height: height }" id="map"></div>
  </div>
</template>

<script>
import axios from "axios";
import { ModelSelect } from "vue-search-select";
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
      IDCustomer: "",
      View: [],
      marker: "",
      icon: "",
      ui: {},
      suggests: []
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

      this.IDCustomer = id;
      this.AddressCustomer = _address;
      this.NoteCustomer = _note;
      var self = this;
      var _lat, _lng, suggestAddress, urlGetAddress, urlGetAddressFromCoord;

      if (this.map.getObjects(this.marker) != null) {
        if (this.map.getObjects(this.marker) != "")
        {
            this.map.removeObject(this.marker);
        }
      }

      if (id==null && _address == null && _note == null)
      {
        return;
      }


      this.icon = new H.map.Icon("/static/icons/marker.png");
      
      //get list suggestion
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

              //set data to send to server
              this.$session.set("ID", {
                ID: id,
                lat: _lat,
                lng: _lng
              });

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
      zoom: 18,
      center: { lng: this.lng, lat: this.lat }
    });

    this.behavior = new H.mapevents.Behavior(
      new H.mapevents.MapEvents(this.map)
    );
    this.ui = new H.ui.UI.createDefault(this.map, defaultLayers);
  },
  // updated() {
  //   this.$emit("AddressCustomer", this.AddressCustomer);
  // },
  methods: {
    Located: function(IDCustomer) {
      EventBus.$emit("sendId", null, null, null);

      axios
        .post(
          "http://192.168.1.10:3000/api/bookingBike/verifyRequestBooking",
          this.$session.get("ID"),
          {
            headers: {
              "x-access-token": this.$session.get("access_token")
            }
          }
        )
        .then(response => {
          if (response.data.msg == "verify success!") {
            EventBus.$emit("removeItem", IDCustomer);
          }
        })
        .catch(err => {
          alert(err);
        });
    },
    keymonitor() {
      document.getElementById("listAddressSuggest").style.display = "block";
      var input = document.getElementById("address").value;
      var urlGetSuggestAddress = `http://autocomplete.geocoder.api.here.com/6.2/suggest.json?query=${input}&app_id=${
        this.appId
      }&app_code=${this.appCode}`;

      axios.get(urlGetSuggestAddress).then(result => {
        this.suggests = result.data.suggestions;
      });
    },
    ChangeAddress(label) {
      document.getElementById("listAddressSuggest").style.display = "none";
      EventBus.$emit("sendId", "", label, "");
    }
  },
  watch: {
    AddressCustomer: _newAddress => {
      this.AddressCustomer = _newAddress;
    }
  }
};
</script>

