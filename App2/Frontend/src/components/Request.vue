<template>
    <ul >
        <li v-for="item in requests" :key="item.id" style=" list-style-type: none;">
            <div class="row" id="item" v-on:click="Indentify(item.id)">
                <div class="col-xs-6 col-sm-6 col-md-6 col-lg-6">
                    {{item.id}}
                </div>
                <div class="col-xs-6 col-sm-6 col-md-6 col-lg-6">
                    {{item.time}}
                </div>  
            </div>
        </li>
    </ul>
</template>

<script>

export default {
  data() {
    return {
            requests: [
                {id: 1, time: 11, note: 112},
                {id: 2, time: 10},
                {id: 3, time: 'Book'},
            ]
    };
  },
  methods:{
      Indentify(id) {

          EventBus.$emit('sendId', id);

        //   this.$session.set('id', id);
          var item = this.requests.find(x => x.id == id);
        //   this.$session.set('note', item.note);
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
