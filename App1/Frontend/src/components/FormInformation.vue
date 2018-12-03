<template>
<div>
    <div id="modalFail" class="modal-backdrop" style="height: 100% !important; display: none; width: 100% !important; background-color: transparent !important;">
        <div class="modal" role="dialog" style="display: block; padding-top: 200px; background-color: rgba(0,0,0,0.5);">
            <div class="modal-dialog" role="document">
                <div class="modal-content" style="padding: 20px; border: none !important; border-radius: 10px;">
                    <div>
                        <h5 class="mdTitle">Lỗi gửi</h5>
                    </div>
                    <div class="mdDes">
                        <p>Gửi thất bại.</p>
                    </div>
                    <div style="text-align: right">
                        <button id="tryAgain" type="button" class="mdBtn">Nhập lại</button>
                    </div>
                </div>
            </div>
        </div>
    </div>
        <div id="modalSucceed" class="modal-backdrop" style="height: 100% !important; display: none; width: 100% !important; background-color: transparent !important;">
        <div class="modal" role="dialog" style="display: block; padding-top: 200px; background-color: rgba(0,0,0,0.5);">
            <div class="modal-dialog" role="document">
                <div class="modal-content" style="padding: 20px; border: none !important; border-radius: 10px; border: 5px solid #0FA9D6;">
                    <div>
                        <h5 class="mdTitle">Thành công</h5>
                    </div>
                    <div class="mdDes">
                        <p>Gửi thành công.</p>
                    </div>
                    <div style="text-align: right">
                        <button id="close" type="button" class="mdBtn">Đóng</button>
                    </div>
                </div>
            </div>
        </div>
    </div>  

   <div class="coverBg">
        <div id="logoutBtn" style="position: fixed; width: 100%; text-align: right; z-index: 99;" v-on:click="LogOut()">
            <button class="logoutBtn">ĐĂNG XUẤT<Table></Table></button>
        </div>
        <img id="cover" src="/static/pics/cover-receiver.png" style="width: 100%; height: auto; opacity: 1; margin-bottom: 0px;">
    </div>
    <div class="container">
        <div class="content blueText center" style="margin-top: -60px;">
            <div class="tit">Nhập thông tin hành khách</div>
            <form style="margin: 20px 50px 0 150px;" action="" method="POST" v-on:submit.prevent="sendinfo">
                <div class="row">
                    <div class="col-md-5">
                        <p for="name" class="inputTit" style="margin-left: -230px;">HỌ TÊN</p>
                        <input id="name" type="text" style="width: 330px;" name="name" v-model="formdata.name"
                            placeholder="Trần Văn A">
                        <p for="address" class="inputTit" style="margin-left: -190px; margin-top: 20px">ĐỊA CHỈ ĐÓN</p>
                        <input id="address" type="text" name="adress" v-model="formdata.address"
                            placeholder="227 Nguyễn Văn Cừ, P4, Q5" style="width: 330px;"> 
                    </div>
                    <div class="col-md-5">
                        <p for="phone" class="inputTit" style="margin-left: -170px;">SỐ ĐIỆN THOẠI</p>
                        <input id="phone" type="text" name="phone" v-model="formdata.phone" placeholder="01234567xx" style="width: 330px;">
                        <p for="note" class="inputTit" style="margin-left: -225px; margin-top: 20px">GHI CHÚ</p>
                        <input id="note" type="text" name="note" v-model="formdata.note"
                            placeholder="Đón ở cổng..." style="width: 330px;">
                    </div>
                    <div class="col-md-1">
                        <button type="submit" class="submitBtn" style="margin-top: 122px; margin-left: -20px"><img src="/static/icons/next.png"></button>
                    </div>
                </div>
            </form>
        </div>
    </div>
</div>
</template>

<script>

$(document).ready(function() {
    $("#submitBtn").click(function() {
    if ($("#name").val() == "") {
      $("#name").addClass("redBorder");
      $("#name").addClass("errorPH");
      $("#name").attr("placeholder", "Vui lòng nhập tên khách");
    }
    if ($("#address").val() == "") {
      $("#address").addClass("redBorder");
      $("#address").addClass("errorPH");
      $("#address").attr("placeholder", "Vui lòng nhập địa chỉ đón");
    }
    if ($("#phone").val() == "") {
      $("#phone").addClass("redBorder");
      $("#phone").addClass("errorPH");
      $("#phone").attr("placeholder", "Vui lòng nhập số điện thoại");
    }
  });
  $("#name").focusout(function() {
    if ($("#name").val() == "") {
      $("#name").addClass("redBorder");
      $("#name").addClass("errorPH");
      $("#name").attr("placeholder", "Vui lòng nhập tên khách");
    }
  });
  $("#address").focusout(function() {
    if ($("#address").val() == "") {
      $("#address").addClass("redBorder");
      $("#address").addClass("errorPH");
      $("#address").attr("placeholder", "Vui lòng địa chỉ đón");
    }
  });
  $("#phone").focusout(function() {
    if ($("#phone").val() == "") {
      $("#phone").addClass("redBorder");
      $("#phone").addClass("errorPH");
      $("#phone").attr("placeholder", "Vui lòng nhập số điện thoại");
    }
  });
  $("#name").click(function() {
    $("#name").removeClass("redBorder");
    $("#name").removeClass("errorPH");
    $("#name").attr("placeholder", "");
  });
  $("#address").click(function() {
    $("#address").removeClass("redBorder");
    $("#address").removeClass("errorPH");
    $("#address").attr("placeholder", "");
  });
  $("#phone").click(function() {
    $("#phone").removeClass("redBorder");
    $("#phone").removeClass("errorPH");
    $("#phone").attr("placeholder", "");
  });
  $("#tryAgain").click(function() {
    $("#modalFail").fadeOut("fast");
  });
  $("#close").click(function() {
    $("#modalSucceed").fadeOut("fast");
  });
});

import axios from "axios";
import {IPGlobal} from "../main.js";

export default {
  data() {
    return {
      title: "Send Information",
      formdata: {},
      message: "",
      success: 0
    };
  },
  methods: {
    sendinfo() {
        var flag = true;
        if ($("#name").val() == "") {
        $("#name").addClass("redBorder");
        $("#name").addClass("errorPH");
        $("#name").addClass("errorShake");
        setTimeout(function(){$("#name").removeClass("errorShake")},500);
        flag=false;
        $("#name").attr("placeholder", "Vui lòng nhập tên khách");
      }
      if ($("#address").val() == "") {
        $("#address").addClass("redBorder"); 
        $("#address").addClass("errorPH");
        $("#address").attr("placeholder", "Vui lòng nhập địa chỉ đón");
        $("#address").addClass("errorShake");
        setTimeout(function(){$("#address").removeClass("errorShake")},500);
        flag=false;
      }
      if ($("#phone").val() == "") {
        $("#phone").addClass("redBorder");
        $("#phone").addClass("errorPH");
        $("#phone").attr("placeholder", "Vui lòng nhập số điện thoại");
        $("#phone").addClass("errorShake");
        setTimeout(function(){$("#phone").removeClass("errorShake")},500);
        flag=false;
      }
      if (flag==true) {
      axios
        .post(`http://${IPGlobal.IP}:3000/api/bookingBike/book`, this.formdata, {
          headers: {
            'x-access-token': this.$localStorage.get('access_token')
          }
        })
        .then(response => {
          if (response.data.success > 0) {
            $("#modalSucceed").fadeIn();
          } else {
            $("#modalFail").fadeIn();
          }
        })
        .catch(err => {
          $("#modalFail").fadeIn();
        });
    }
    },
    LogOut(){
        this.$localStorage.remove("access-token");
      this.$localStorage.remove("refresh-token");
      this.$router.replace({ name: "FormLogin" });
    }
  }
};
</script>

