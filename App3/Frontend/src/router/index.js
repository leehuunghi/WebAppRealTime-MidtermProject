import Vue from 'vue'
import Router from 'vue-router'
import FormLogin from '@/components/FormLogin'
import Manage from '@/components/Manage'
import MapRouter from '@/components/MapRouter'

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
      path: 'login',
      name: 'FormLogin',
      component: FormLogin
    },
    {
      path: '/manage',
      name: 'Manage',
      component: Manage
    },
    {
      path: '/map-router',
      name: 'MapRouter',
      component: MapRouter
    }
  ]
})