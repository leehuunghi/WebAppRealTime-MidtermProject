<template>
<div style="width: 100% important; height: 600px; overflow:scroll; overflow-x:hidden;">
  <div style="margin-right: 15px;">
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
            <div class="row click" :id="item.ID" v-on:click="Indentify(item.ID, item.address, item.note)">
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
</div>
</template>

<script>
import axios from "axios";
import VueMoment from "moment";

export default {
  data() {
    return {
      requests: []
    };
  },
  created() {
    var self = this;
    axios
      .get(
        "http://172.168.10.107:3000/api/bookingBike/loadAllRequestBookingWaiting",
        {
          headers: {
            "x-access-token": this.$localStorage.get("access_token")
          }
        }
      )
      .then(result => {
        for (
          let index = 0;
          index < result.data.listRequestBooking.length;
          index++
        ) {
          var item = result.data.listRequestBooking[index];
          result.data.listRequestBooking[index].time = VueMoment.unix(
            item.time
          ).format("DD/MM/YYYY HH:mm");
        }
        this.requests = result.data.listRequestBooking;
      })
      .catch(err => {
        alert(err);
      });

    EventBus.$on("removeItem", IDCustomer => {
      var index = this.requests.findIndex(x => x.ID == IDCustomer);
      this.requests.splice(index, 1);
      for (
        let index = 0;
        index < document.getElementsByClassName("click").length;
        index++
      ) {
        document.getElementsByClassName("click")[index].style.color = "black";
      }
    });
  },
  mounted() {
    this.$sse("http://172.168.10.107:3000/api/a", { format: "json" })
      .then(sse => {
        sse.subscribe("REQUEST_BOOKING", response => {
          response[0].time = VueMoment.unix(response[0].time).format(
            "DD/MM/YYYY HH:mm"
          );
          this.requests.unshift(response[0]);
        });
      })
      .catch(err => {
        alert(err);
      });
  },
  methods: {
    Indentify(id, address, note) {
      for (
        let index = 0;
        index < document.getElementsByClassName("click").length;
        index++
      ) {
        document.getElementsByClassName("click")[index].style.color = "black";
      }

      document.getElementById(id).style.color = "#0FA9D6";
      EventBus.$emit("sendId", id, address, note);

      // var item = this.requests.find(x => x.id == id);
    }
  },
  watch: {
    requests: _newRequest => {
      this.requests = _newRequest;
    }
  }
};
</script>

