<template>
<div>
  <div class="view img-responsive cover">
      <div class="view img-responsive avatar-identifier">
        <img src="/static/pics/logo-desktop.png" width="60px" style="margin: 10px;">
      </div>
  </div>
 <div class="content blueText center" style="margin-top: 200px;">
        <div class="tit">Đăng nhập để tiếp tục</div>
         <form action="" method="POST" v-on:submit.prevent="sendLogin" style="margin-top: 20px;"> 
            <p for="username" class="inputTit" style="margin-left: -160px;">TÊN ĐĂNG NHẬP</p>
            <input id="username" type="text" placeholder="Nhập tên đăng nhập" v-model="formdata.username"  style="width: 330px;">
            <p for="username" class="inputTit" style="margin-left: -205px; margin-top: 20px">MẬT KHẨU</p>
            <input id="password" type="password" placeholder="Nhập mật khẩu" v-model="formdata.password" style="width: 330px; margin-right: 20px; margin-left: 70px;">
            <button class="submitBtn" type="submit"><img src="/static/icons/next.png"></button>
        </form>
    </div>
</div>
</template>

<script>
import axios from "axios";
import md5 from "crypto-md5";
export default {
  data() {
    return {
      title: "Login",
      formdata: {
        role: "employee"
      },
      auth: "",
      access_token: "",
      refresh_token: ""
    };
  },
  methods: {
    sendLogin() {
      var passmd5 = md5($("#password").val());
      this.formdata.password = passmd5;
      axios
        .post("http://172.16.0.254:3000/api/employee/login", this.formdata)
        .then(response => {
   
          if (response.data.auth) {
            this.auth = response.data.auth;
            this.access_token = response.data.access_token;
            this.refresh_token = response.data.refresh_token;
            this.$session.set("access_token", response.data.access_token);
            this.$session.set("refresh_token", response.data.refresh_token);
            this.$emit("authenticated", true);
            this.$router.replace({ name: "Confirm" });
          } else {
          }
        })
        .catch(err => {
          alert(err);
        });
    }
  }
};
</script>