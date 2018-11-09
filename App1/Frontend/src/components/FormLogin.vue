<template>
<div>
   <p id="titleForm">Đăng nhập để tiếp tục</p>
     <form action="" method="POST" v-on:submit.prevent="sendLogin">

            <div class="row">
                <div class="col-xs-10 col-sm-10 col-md-10 col-lg-10">
                    <div class="form-group">
                        <label>TÊN ĐĂNG NHẬP</label>
                        <input type="text" name="username" class="form-control" v-model="formdata.username" id="hoten"
                            placeholder="Trần Văn A">
                    </div>
                    <div class="form-group">
                        <label>MẬT KHẨU</label>
                        <input type="password" name="password" class="form-control" v-model="formdata.password" id="sdt" placeholder="******">
                    </div>
                </div>
                <div class="col-xs-2 col-sm-2 col-md-2 col-lg-2">
                    <button type="submit" id="btnSubmit">
                        <img src="/static/image/right-arrow.png" id="imgSubmit">
                    </button>
                </div>
            </div>

        </form>
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
      var passmd5 = md5($("#hoten").val());
      this.formdata.password = passmd5;
      axios
        .post("http://192.168.1.48:3000/api/employee/login", this.formdata)
        .then(response => {
          if (response.data.auth) {
            this.auth = response.data.auth;
            this.access_token = response.data.access_token;
            this.refresh_token = response.data.refresh_token;

            this.$session.set('access_token', response.data.access_token);
            this.$session.set('refresh_token', response.data.refresh_token);

            this.$emit("authenticated", false);
            this.$router.replace({ name: "FormInformation" });
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

