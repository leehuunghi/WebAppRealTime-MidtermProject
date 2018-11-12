<template>
  <div id="confirm" class="row">
    <div class="col-xs-6 col-sm-6 col-md-6 col-lg-6">
        <Request/>
    </div>
    <div class="col-xs-6 col-sm-6 col-md-6 col-lg-6">
       <HereMap
            appId="SxxR970XbZjWq11DxSea"
            appCode="ZIgTe3WyzSsHXAsKjPBljg"
            lat="10.762622"
            lng="106.660172"
            width="100%"
            height="835px" />
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
  }
};
</script>