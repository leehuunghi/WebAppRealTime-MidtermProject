import Vue from 'vue'
import Router from 'vue-router'
import FormLogin from '@/components/FormLogin'

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
    }
  ]
})
