<template>
  <div id="app">
   <router-view :to="{ name: 'FormLogin' }"/>
   <!-- <router-view :to="{ name: 'Manage' }" />
   <router-view :to="{ name: 'MapRouter' }" /> -->
   <div v-if= "authenticated" style="position: absolute; top: 20px; right: 20px;" v-on:click="LogOut()">
        <button class="logoutBtn">ĐĂNG XUẤT</button>
    </div>
</div>
</template>

<script>
import axios from "axios";

export default {
  data: {
    name: "App",
    authenticated: false
  },
  created() {
    var access_token = this.$localStorage.get("access_token");
    if (access_token != null) {
      axios
        .post("http://172.16.1.21:3000/api/me", "", {
          headers: {
            "x-access-token": access_token
          }
        })
        .then(response => {
          alert(JSON.stringify(response));
          if (response.data.auth == 1) {
            this.authenticated = true;
            this.$router.replace({ name: "Manage" });
          }
        })
        .catch(err => {
          this.$router.replace({ name: "FormLogin" });
        });
    } else this.$router.replace({ name: "FormLogin" });
  },
  methods: {
    LogOut() {
      alert(1);
      this.$localStorage.remove("access-token");
      this.$localStorage.remove("refresh-token");
      this.$router.replace({ name: "FormLogin" });
    }
  }
};
</script>
