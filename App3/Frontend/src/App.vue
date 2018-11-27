<template>
  <div id="app">
   <router-view :to="{ name: 'FormLogin' }"/>
</div>
</template>

<script>
import axios from "axios";

export default {
  data: {
    name: "App",
  },
  created() {
    var access_token = this.$localStorage.get("access_token");

    if (access_token != null) {
      axios
        .post("http://192.168.1.5:3000/api/me", "", {
          headers: {
            "x-access-token": access_token
          }
        })
        .then(response => {
          if (response.data.auth == 1) {
            this.$router.replace({ name: "Manage" });
          }
        })
        .catch(err => {
            // var refresh_token = this.$localStorage.get("refresh_token");
            // alert(refresh_token);
            // axios
            //   .post(
            //     "http://192.168.1.5:3000/api/updateAccessToken",
            //     {refresh_token}
            //   )
            //   .then(newAccessToken => {
            //      this.$log.info('test', newAccessToken);
            //     this.$localStorage.set("access_token", newAccessToken.data.access_token);
            //     this.$router.replace({ name: "Manage" });
            //   }).catch(err=>{
                this.$router.replace({ name: "FormLogin" });
              // });
        });
    } else this.$router.replace({ name: "FormLogin" });
  },
};
</script>
