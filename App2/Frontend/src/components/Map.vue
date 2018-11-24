<template>
  <div class="here-map">
         <div id="modalFail" class="modal-backdrop" style="height: 100% !important; display: none; width: 100% !important; background-color: transparent !important; z-index: 999999999;">
        <div class="modal" role="dialog" style="display: block; padding-top: 200px; background-color: rgba(0,0,0,0.5);">
            <div class="modal-dialog" role="document">
                <div class="modal-content" style="padding: 20px; border: none !important; border-radius: 10px;">
                    <div>
                        <h5 class="mdTitle">Sai địa chỉ</h5>
                    </div>
                    <div class="mdDes">
                        <p>Không tìm thấy địa điểm.</p>
                    </div>
                    <div style="text-align: right">
                        <button id="tryAgain-m" v-on:click="tryClose()" type="button" class="mdBtn">Thử lại</button>
                    </div>
                </div>
            </div>
        </div>
    </div> 

    <div id="modalSucceed" class="modal-backdrop" style="height: 100% !important; display: none; width: 100% !important; background-color: transparent !important; z-index: 999999999;">
        <div class="modal" role="dialog" style="display: block; padding-top: 200px; background-color: rgba(0,0,0,0.5);">
            <div class="modal-dialog" role="document">
                <div class="modal-content" style="padding: 20px; border: none !important; border-radius: 10px; border: 5px solid #0FA9D6;">
                    <div>
                        <h5 class="mdTitle">Thành công</h5>
                    </div>
                    <div class="mdDes">
                        <p>Định vị thành công.</p>
                    </div>
                    <div style="text-align: right">
                        <button id="close-m" v-on:click="closeClose()" type="button" class="mdBtn">ĐÓNG</button>
                    </div>
                </div>
            </div>
        </div>
    </div>  

                <div class="info">
                    <div class="row">
                        <div class="col-md-6">
                            <div class="colTit">
                                Địa chỉ
                            </div>
                            <input type="text" v-model="AddressCustomer" v-on:keyup="keymonitor" id="address" style="margin-bottom: 5px; width: 400px !important; height: auto !important; padding: 5px 20px !important;">
                            <div id="listAddressSuggest" class="sugFrame" style="display: none;">
                                <div v-for="item in suggests" :key="item.id" style="font-size: 14px;">
                                
                                  <span id="sug" v-on:click="ChangeAddress(item.label)">{{item.label}}</span>      
                                  
                                </div>
                            </div>
                        </div>
                        <div class="col-md-4">
                            <div class="colTit">
                                Ghi chú
                            </div>
                           
                            <p class="note" style="!important; height: 33px; background-color: #f9f9f9; margin-bottom: 5px; !important; padding: 5px 20px !important;" id="note">{{NoteCustomer}}</p>
                            
                        </div>
                        <div class="col-md-2" style="text-align: right; margin-top: 7px;">
                            <button class="locateBtn" id="locateBtn" v-on:click="Located(IDCustomer)">Định vị</button>
                        </div>
                    </div>
                </div>
         <div>
      <div class="center" ref="map" v-bind:style="{ width: width, height: '600px' }" id="map"></div>
         </div>
  </div>
</template>

<script>
$(document).ready(function() {
  $("#address").keyup(function() {
    if ($("#address").val() != "") {
      $("#listAddressSuggest").show();
    } else {
      $("#listAddressSuggest").hide();
    }
  });
});

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
      if (_note == "undefined") _note = "";
      this.NoteCustomer = _note;
      var self = this;
      var _lat, _lng, suggestAddress, urlGetAddress, urlGetAddressFromCoord;

      if (this.map.getObjects(this.marker) != null) {
        if (this.map.getObjects(this.marker) != "") {
          this.map.removeObject(this.marker);
        }
      }

      if (id == null && _address == null && _note == null) {
        return;
      }

      this.icon = new H.map.Icon("/static/icons/marker.png");

      //get list suggestion
      var urlGetSuggestAddress = `http://autocomplete.geocoder.api.here.com/6.2/suggest.json?query=${
        this.AddressCustomer
      }&app_id=${this.appId}&app_code=${this.appCode}`;

      axios.get(urlGetSuggestAddress).then(result => {
        if (result.data.suggestions.length == 0) {
          $("#modalFail").fadeIn(200);
          $("#locateBtn").fadeOut(200);
        } else {
          $("#locateBtn").fadeIn(200);
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
                lng: _lng,
                usernameDriver: ""
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

              //set data to send to server
              this.$session.set("ID", {
                ID: id,
                lat: +self.lat,
                lng: +self.lng,
                usernameDriver: ""
              });

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
    tryClose: function(){
      $("#modalFail").fadeOut();
    },
    closeClose: function(){
      $("#modalSucceed").fadeOut();
    },
    Located: function(IDCustomer) {
      EventBus.$emit("sendId", null, null, null);
      axios
        .post(
          "http://172.168.10.107:3000/api/bookingBike/verifyRequestBooking",
          this.$session.get("ID"),
          {
            headers: {
              "x-access-token": this.$localStorage.get("access_token")
            }
          }
        )
        .then(response => {
          if (response.data.msg == "verify success!") {
            EventBus.$emit("removeItem", IDCustomer);
            $("#modalSucceed").fadeIn();
          } else {
            $("#modalFail").fadeIn();
            $("#locateBtn").fadeOut();
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
      $("#locateBtn").fadeIn();
    }
  },
  watch: {
    AddressCustomer: _newAddress => {
      this.AddressCustomer = _newAddress;
    }
  }
};
</script>

