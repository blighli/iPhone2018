// The Vue build version to load with the `import` command
// (runtime-only or standalone) has been set in webpack.base.conf with an alias.
import Vue from 'vue'
import FastClick from 'fastclick'
import VueRouter from 'vue-router'
import App from './App'
import VueResource from 'vue-resource'
import Home from './components/HelloFromVux'
import HelloWorld from './components/HelloWorld'
import TicketContainer from './components/TicketContainer'
import PreferContainer from './components/PreferContainer'
import TicketDetail from './components/TicketDetail'

Vue.use(VueRouter)
Vue.use(VueResource)

const routes = [
  {
  path: '/',
  component: Home
},
{
  path:'/HelloWorld',
  component:HelloWorld,
},
{
  path:'/Prefer',
  component:PreferContainer,
},
{
  path:'/Ticket',
  component:TicketContainer,
},
{
  path:'/TicketDetail',
  component:TicketDetail,
},
]

const router = new VueRouter({
  routes
})

FastClick.attach(document.body)

Vue.config.productionTip = false
Vue.prototype.HOST='/api'

/* eslint-disable no-new */
new Vue({
  router,
  render: h => h(App)
}).$mount('#app-box')
