import Vue from 'vue'
import Router from 'vue-router'
import FormInformation from '@/components/FormInformation'
import FormLogin from '@/components/FormLogin'

Vue.use(Router)

export default new Router({
  routes: [
    {
      path: '',
      name: 'FormLogin',
      component: FormLogin
    },
    {
      path: '/form',
      name: 'FormInformation',
      component: FormInformation
    },
  ]
})
