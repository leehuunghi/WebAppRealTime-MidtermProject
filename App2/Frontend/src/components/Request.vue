<template>
<div>
    <ul id="newItem" v-on:click="CheckClick"></ul>
    <ul>
        <li v-for="item in requests" :key="item.id" style=" list-style-type: none;">
            <div class="row" id="item" v-on:click="Indentify(item.id)">
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
      .get("http://172.16.0.254:3000/api/bookingBike/loadAllRequestBooking", {
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
    this.$sse("http://172.16.0.254:3000/api/a", { format: "json" })
      .then(sse => {
        sse.subscribe("REQUEST_BOOKING", response => {
          var liNew = `<li style=" list-style-type: none;" id="${response[0].ID}">
            <div class="row new" id="item">
                <div class="col-xs-6 col-sm-6 col-md-6 col-lg-6">
                   # ${response[0].ID}
                </div>
                <div class="col-xs-6 col-sm-6 col-md-6 col-lg-6">
                    ${response[0].time}
                </div>  
            </div>
        </li>`;
          $("#newItem").append(liNew);
        });
      })
      .catch(err => {
        alert(err);
      });

  },
  methods: {
    Indentify(id) {
      alert("Identify");
      EventBus.$emit("sendId", id);

      var item = this.requests.find(x => x.id == id);
    },

    CheckClick(){

      alert("CheckList");
      alert(JSON.stringify($("#newItem li.selected").attr('id')));
    // $("#newItem").on('click', Indentify($("#newItem li.selected").text()));
    alert(2);
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
