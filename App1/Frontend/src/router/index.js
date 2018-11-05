import Vue from 'vue'
import Router from 'vue-router'
import FormInformation from '@/components/FormInformation'
import FormLogin from '@/components/FormLogin'

Vue.use(Router)

export default new Router({
  routes: [
    {
      path: 'form',
      name: 'FormInformation',
      component: FormInformation
    },
    {
      path: '',
      name: 'FormLogin',
      component: FormLogin
    }
  ]
})
