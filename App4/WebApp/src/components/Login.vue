<template>
  <div>
     <div id="modal" class="modal-backdrop" style="background-color: rgba(0,0,0,0.5); display: none;">
        <div class="modal" role="dialog" style="display: block; padding-top: 200px; margin-left: 20px; margin-right: 20px;">
            <div class="modal-dialog" role="document">
                <div class="modal-content" style="padding: 20px; border: none !important; border-radius: 10px;">
                    <div>
                        <h5 class="mdTitle">Lỗi đăng nhập</h5>
                    </div>
                    <div class="mdDes">
                        <p>Tên đăng nhập hoặc mật khẩu không đúng.</p>
                    </div>
                    <div style="text-align: right">
                        <button id="tryAgain" type="button" class="mdBtn">Nhập lại</button>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <div style="width: 100%;">
        <div class="welcome">Chào mừng đến với</div>
        <div><img src="/static/pics/cover.png" width="100%"></div>
    </div>
     <div class="content blueText center" style="margin-top: 10px;">
        <div class="tit">Đăng nhập để tiếp tục</div>

        <form id="signin" style="margin-top: 20px;" action="receiver-main.html" method="POST" v-on:submit.prevent="sendLogin">
            <div style="margin-left: 10%; margin-right: 10%;">
                <div style="width: 80%;">
                    <p for="username" class="inputTit" style="margin-left: -80px;">TÊN ĐĂNG NHẬP</p>
                    <input id="username" type="text" placeholder="Nhập tên đăng nhập" v-model="formdata.username" style="width: 226px; height: 35px;">
                    <p for="username" class="inputTit" style="margin-left: -115px; margin-top: 20px" >MẬT KHẨU</p>
                    <input id="password" type="password" placeholder="Nhập mật khẩu" v-model="formdata.password" style="width: 226px; height: 35px;">
                </div>
                <div style="width: 20%; float: right; margin-top: -35px;">
                    <button type="submit" id="submitBtn" value="send" class="submitBtn"><img src="/static/icons/next.png" width="14px"></button>
                </div>
            </div>
        </form>
    </div>

  </div>
</template>

<script>
$(document).ready(function() {
  $("#submitBtn").click(function() {
    if ($("#username").val() == "") {
      $("#username").addClass("redBorder");
      $("#username").addClass("errorPH");
      $("#username").attr("placeholder", "Vui lòng nhập tên đăng nhập");
    }
    if ($("#password").val() == "") {
      $("#password").addClass("redBorder");
      $("#password").addClass("errorPH");
      $("#password").attr("placeholder", "Vui lòng nhập mật khẩu");
    }
    // } else {
    //   // $("#signin").submit();
    //   // $("#modal").fadeIn("fast");
    // }
  });
  $("#username").focusout(function() {
    if ($("#username").val() == "") {
      $("#username").addClass("redBorder");
      $("#username").addClass("errorPH");
      $("#username").attr("placeholder", "Vui lòng nhập tên đăng nhập");
    }
  });
  $("#password").focusout(function() {
    if ($("#password").val() == "") {
      $("#password").addClass("redBorder");
      $("#password").addClass("errorPH");
      $("#password").attr("placeholder", "Vui lòng nhập mật khẩu");
    }
  });
  $("#username").click(function() {
    $("#username").removeClass("redBorder");
    $("#username").removeClass("errorPH");
    $("#username").attr("placeholder", "");
  });
  $("#password").click(function() {
    $("#password").removeClass("redBorder");
    $("#password").removeClass("errorPH");
    $("#password").attr("placeholder", "");
  });
  $("#tryAgain").click(function() {
    $("#modal").fadeOut("fast");
  });
});

import axios from "axios";
import md5 from "crypto-md5";

export default {
  data() {
    return {
      title: "Login",
      formdata: {
        role: "driver"
      },
      auth: "",
      access_token: "",
      refresh_token: "",
      loginfail: true
    };
  },
  methods: {
    sendLogin() {
      if ($("#username").val() == "") {
        $("#username").addClass("redBorder");
        $("#username").addClass("errorPH");
        $("#username").attr("placeholder", "Vui lòng nhập tên đăng nhập");
      }
      if ($("#password").val() == "") {
        $("#password").addClass("redBorder");
        $("#password").addClass("errorPH");
        $("#password").attr("placeholder", "Vui lòng nhập mật khẩu");
      } else {
        var passmd5 = md5($("#password").val());
        this.formdata.password = passmd5;
        axios
          .post("http://192.168.0.45:3000/api/employee/login", this.formdata)
          .then(response => {
            if (response.data.auth) {
              this.auth = response.data.auth;
              this.access_token = response.data.access_token;
              this.refresh_token = response.data.refresh_token;
              this.$localStorage.set(
                "access_token",
                response.data.access_token
              );
              this.$localStorage.set(
                "refresh_token",
                response.data.refresh_token
              );
              this.$session.set("username", this.formdata.username);
              this.$router.replace({ name: "Main" });
            }
            else{
                $("#modal").fadeIn("fast");
            }
          })
          .catch(err => {
            alert(err);
          });
      }
    }
  }
};
</script>