import Vue from 'vue'
import Router from 'vue-router'
import FormInformation from '@/components/FormInformation'

Vue.use(Router)

export default new Router({
  routes: [
    {
      path: '/',
      name: 'FormInformation',
      component: FormInformation
    }
  ]
})
