<template>
<div>
  <div class="navbar">
        <div class="row" style="width: 100%;">
            <div class="col-md-2">
                <img src="/static/pics/logo-desktop-white.png" width="60px;" style="margin: 0 10px 0 0;">
            </div>
            <div class="col-md-8 navTitle">
                    <img src="/static/icons/back.png" style="margin-right: 100px">
                    Đường đi ngắn nhất
            </div>
            <div class="col-md-2" style="text-align: right;">
                <div>
                    <button class="logoutBtn-r">ĐĂNG XUẤT</button>
                </div>
            </div>
        </div>
    </div>
    <div ref="map" v-bind:style="{ width: width, height: height }" id="map"></div>
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
  created()
  {
    this.platform = new H.service.Platform({
      app_id: this.appId,
      app_code: this.appCode
    });
  },
  mounted () { 
    // Initialize the platform object:
    this.platform = new H.service.Platform({
      app_id: 'SxxR970XbZjWq11DxSea',
      app_code: 'ZIgTe3WyzSsHXAsKjPBljg',
      useCIT: true,
      useHTTPS: true,
    });

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
};
</script>