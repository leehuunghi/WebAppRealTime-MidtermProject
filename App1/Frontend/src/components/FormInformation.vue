<template>
<div>
    <p id="titleForm">Nhập thông tin hành khách</p>
  <form action="" method="POST" v-on:submit.prevent="sendinfo">
            <div class="row">
                <div class="col-xs-5 col-sm-5 col-md-5 col-lg-5">
                    <div class="form-group">
                        <label>HỌ TÊN</label>
                        <input type="text" name="name" class="form-control" v-model="formdata.name" id="hoten"
                            placeholder="Trần Văn A">
                    </div>
                    <div class="form-group">
                        <label>SỐ ĐIỆN THOẠI</label>
                        <input type="text" name="phone" class="form-control" v-model="formdata.phone" id="sdt" placeholder="01234567xx">
                    </div>
                </div>
                <div class="col-xs-5 col-sm-5 col-md-5 col-lg-5">
                    <div class="form-group">
                        <label>ĐỊA CHỈ ĐÓN</label>
                        <input type="text" name="adress" class="form-control" v-model="formdata.adress" id="diachi"
                            placeholder="227 Nguyễn Văn Cừ, P4, Q5">
                    </div>
                    <div class="form-group">
                        <label>GHI CHÚ</label>
                        <input type="text" name="note" class="form-control" v-model="formdata.note" id="ghichu"
                            placeholder="Đón ở cổng...">
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
import token from "@/components/FormLogin"

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
        .post("http://172.16.1.32:3000/api/bookingBike/book", this.formdata, {
            headers: {
                'x-access-token':  this.$session.get('access_token')
            }
        })
        .then(response => {
          console.log(response);
          if (response.data.success > 0) {
            this.message = "You send information success";
            this.success = response.data.success;
          } else {
            this.message = "You send information fail";
            this.success = response.data.success;
          }
        })
        .catch(err => {
          alert(err);
        });
    }
  }
};
</script>

