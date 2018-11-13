<template>
<div>
    <ul>
        <li v-for="item in requests" :key="item.id" style=" list-style-type: none;">
            <div class="row" id="item" v-on:click="Indentify(item.id, item.address, item.note)">
                <div class="col-xs-6 col-sm-6 col-md-6 col-lg-6">
                   #{{item.ID}}
                </div>
                <div class="col-xs-6 col-sm-6 col-md-6 col-lg-6">
                    {{item.time}}
                </div>  
            </div>
        </li>
    </ul>
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
      .get("http://192.168.1.13:3000/api/bookingBike/loadAllRequestBooking", {
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
    this.$sse("http://192.168.1.13:3000/api/a", { format: "json" })
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

</<style>
#item{
    text-align: center;
    margin-top: 20px;
    border-width: 1px;
    border-style: solid;
    border-color: black;
    border-radius: 5px;
}

</style>
