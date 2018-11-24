<template>
<div>
   <div class="navbar">
        <div class="row" style="width: 100%;">
            <div class="col-md-2">
                <img src="/static/pics/logo-desktop-white.png" width="60px;" style="margin: 0 10px 0 0;">
            </div>
            <div class="col-md-8 navTitle center">
                Location Identifier
            </div>
            <div class="col-md-2" style="text-align: right;" v-on:click="LogOut()">
                <div>
                    <button class="logoutBtn-r">ĐĂNG XUẤT</button>
                </div>
            </div>
        </div>
    </div>
  <div id="confirm" class="row" style="height: 100%; width: 100%; padding-top: 65px; margin-left: 0px !important;">
    <div class="col-md-4 rightFrame" style="padding-right: 0px">
        <Request/>
    </div>
    <div class="col-xs-8 col-sm-8 col-md-8 col-lg-8" style="padding: 0px;">
       <HereMap
            appId="SxxR970XbZjWq11DxSea"
            appCode="ZIgTe3WyzSsHXAsKjPBljg"
            lat="10.762622"
            lng="106.660172"
            width="100%"
            height="450px" />
    </div>  
  </div>
</div>
</template>

<script>

import Request from "./Request";
import HereMap from "./Map";

export default {
  components: {
    Request,
    HereMap
  },
  methods: {
    LogOut() {
      //   this.$localStorage.remove("access-token");
      //   this.$localStorage.remove("refresh-token");
      this.$router.replace({ name: "FormLogin" });
    }
  }
};
</script>