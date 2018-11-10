import Vue from 'vue'
import Router from 'vue-router'
import FormLogin from '@/components/FormLogin'
import Confirm from '@/components/Confirm'

Vue.use(Router)

export default new Router({
  mode: 'history',
  routes: [
    {
      path: '/',
      redirect: {
          name: "FormLogin"
      }
  },
    {
      path: '/login',
      name: 'FormLogin',
      component: FormLogin
    },
    {
      path: '/confirm',
      name: 'Confirm',
      component: Confirm
    }
  ]
})
