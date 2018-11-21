// The Vue build version to load with the `import` command
// (runtime-only or standalone) has been set in webpack.base.conf with an alias.
import Vue from 'vue'
import App from './App'
import router from './router'

import 'here-js-api/scripts/mapsjs-core';
import 'here-js-api/scripts/mapsjs-service';
import 'here-js-api/scripts/mapsjs-ui';
import 'here-js-api/scripts/mapsjs-mapevents';
import 'here-js-api/scripts/mapsjs-clustering';

import VueSessionStorage from 'vue-sessionstorage'
Vue.use(VueSessionStorage)

import * as uiv from 'uiv'

Vue.use(uiv)

Vue.config.productionTip = false

import VueSSE from 'vue-sse';
Vue.use(VueSSE);

window.EventBus = new Vue({  
  data(){
    return {
      AddressCustomer: 2
    }
  }
 });

/* eslint-disable no-new */
new Vue({
  el: '#app',
  router,
  components: { App },
  template: '<App/>'
})
