<template>
<div>
   <div class="coverBg">
        <div id="logoutBtn" style="position: fixed; width: 100%; text-align: right; z-index: 99;">
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
                        <p for="username" class="inputTit" style="margin-left: -230px;">HỌ TÊN</p>
                        <input id="username" type="text" style="width: 330px;" name="name" class="form-control" v-model="formdata.name"
                            placeholder="Trần Văn A">
                        <p for="username" class="inputTit" style="margin-left: -190px; margin-top: 20px">ĐỊA CHỈ ĐÓN</p>
                        <input id="username" type="text" name="adress" class="form-control" v-model="formdata.address"
                            placeholder="227 Nguyễn Văn Cừ, P4, Q5" style="width: 330px;"> 
                    </div>
                    <div class="col-md-5">
                        <p for="username" class="inputTit" style="margin-left: -170px;">SỐ ĐIỆN THOẠI</p>
                        <input id="username" type="text" name="phone" class="form-control" v-model="formdata.phone" placeholder="01234567xx" style="width: 330px;">
                        <p for="username" class="inputTit" style="margin-left: -225px; margin-top: 20px">GHI CHÚ</p>
                        <input id="username" type="text" name="note" class="form-control" v-model="formdata.note"
                            placeholder="Đón ở cổng..." style="width: 330px;">
                    </div>
                    <div class="col-md-1">
                        <button class="submitBtn" style="margin-top: 122px; margin-left: -20px"><img src="/static/icons/next.png"></button>
                    </div>
                </div>
            </form>
        </div>
    </div>
</div>
</template>

<script>
import axios from "axios";

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
      axios
        .post("http://192.168.1.10:3000/api/bookingBike/book", this.formdata, {
            headers: {
                'x-access-token':  this.$session.get('access_token')
            }
        })
        .then(response => {
          if (response.data.success > 0) {
              alert("Send info success");
          } else {
            alert("Send info fail");
          }
        })
        .catch(err => {
          alert(err);
        });
    }
  }
};
</script>

