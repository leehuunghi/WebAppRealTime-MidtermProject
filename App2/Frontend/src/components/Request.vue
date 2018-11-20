<template>
<div >
 
        <div id="tit" class="row colTit" style="margin: 10px 15px;">
                <div class="col-md-5">
                    ID
                </div>
                <div class="col-md-5">
                    Thời gian
                </div>
                <div class="col-md-2">

                </div>
          </div>
    
        <div v-for="item in requests" :key="item.id" style=" list-style-type: none;" class="request">
            <div class="row" id="item" v-on:click="Indentify(item.ID, item.address, item.note)">
                <div class="col-xs-5 col-sm-5 col-md-5 col-lg-5">
                   #{{item.ID}}
                </div>
                <div class="col-xs-6 col-sm-5 col-md-5 col-lg-5">
                    {{item.time}}
                </div>  
                <div id="req-locate" class="col-md-2" style="text-align: right;">
                        <img src="/static/icons/next-color.png" width="20px" height="auto">
                    </div>
            </div>
        </div>
 
</div>
</template>

<script>
import axios from "axios";

export default {
  data() {
    return {
      requests: []
    };
  },
  created() {
    var self = this;
    axios
      .get("http://172.16.1.21:3000/api/bookingBike/loadAllRequestBooking", {
        headers: {
          "x-access-token": this.$session.get("access_token")
        }
      })
      .then(result => {
        this.requests = result.data.listRequestBooking;
      })
      .catch(err => {
        alert(err);
      });
  },
  mounted() {
    this.$sse("http://172.16.1.21:3000/api/a", { format: "json" })
      .then(sse => {
        sse.subscribe("REQUEST_BOOKING", response => {
          this.requests.push(response[0]);
        });
      })
      .catch(err => {
        alert(err);
      });
  },
  methods: {
    Indentify(id, address, note) {
      EventBus.$emit("sendId", id, address, note);

      var item = this.requests.find(x => x.id == id);
    },
  },
  watch: {
    requests: (_newRequest) =>{
      this.requests = _newRequest;
    }
  }
};
</script>

