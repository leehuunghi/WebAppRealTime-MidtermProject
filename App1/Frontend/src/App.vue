<template>
  <div id="app">
   <router-view :to="{ name: 'FormLogin' }"/>
</div>
</template>

<script>
import axios from "axios";
import { IPGlobal } from './main';

export default {
  data() {
    return{
      name: "App",
    }
  },
  created() {
    var access_token = this.$localStorage.get("access_token");
    if (access_token != null) {
      axios
        .post(`http://${IPGlobal.IP}:3000/api/me`, "", {
          headers: {
            "x-access-token": access_token
          }
        })
        .then(response => {
          if (response.data.auth == 1) {
            this.$router.replace({ name: "FormInformation" });
          }
        })
        .catch(err => {
                this.$router.replace({ name: "FormLogin" });
        });
    } else this.$router.replace({ name: "FormLogin" });
  },
};
</script>