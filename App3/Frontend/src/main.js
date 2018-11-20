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

// import moment from 'moment-timezone'
 
// Vue.use(VueMoment, {
//     // moment,
// })


import VueLocalStorage from 'vue-localstorage'

Vue.use(VueLocalStorage)


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
