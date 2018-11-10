<template>
  <div id="confirm">
    <Address/>
     <HereMap
            appId="SxxR970XbZjWq11DxSea"
            appCode="ZIgTe3WyzSsHXAsKjPBljg"
            lat="37.7397"
            lng="-121.4252"
            width="100%"
            height="835px" />
  </div>
</template>

<script>
import Address from "./Address";
import HereMap from "./Map";

export default {
  components: {
    Address,
    HereMap
  }
};
</script>