<template>
  <div id="app">
   <router-view :to="{ name: 'Login' }"/>
</div>
</template>

<script>
import axios from "axios";
import {IPGlobal} from "./main.js";

export default {
  data() {
    return {
      name: "App",
    }
  },
  created() {
    var access_token = this.$localStorage.get("access_token");
    if (access_token != null) {
      axios
        .post("http://172.16.1.190:3000/api/me", "", {
          headers: {
            "x-access-token": access_token
          }
        })
        .then(response => {
          if (response.data.auth == 1) {
            this.$router.replace({ name: "Main" });
          }
        })
        .catch(err => {
        
                this.$router.replace({ name: "Login" });
              
        });
    } else this.$router.replace({ name: "Login" });
  },
};
</script>