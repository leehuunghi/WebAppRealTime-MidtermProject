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

export const IPGlobal = new Vue({
  data: {
    IP : '172.16.9.40'
  }
})

import VueSSE from 'vue-sse';
Vue.use(VueSSE);

import VueLocalStorage from 'vue-localstorage'

Vue.use(VueLocalStorage)

Vue.use({
  install: function(Vue, options){
      Vue.prototype.$jQuery = require('jquery'); // you'll have this.$jQuery anywhere in your vue project
  }
})

window.EventBus = new Vue();

import VueSessionStorage from 'vue-sessionstorage'
Vue.use(VueSessionStorage)

Vue.config.productionTip = false


/* eslint-disable no-new */
new Vue({
  el: '#app',
  router,
  components: { App },
  template: '<App/>'
})