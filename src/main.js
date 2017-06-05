// The Vue build version to load with the `import` command
// (runtime-only or standalone) has been set in webpack.base.conf with an alias.
import Vue from 'vue'
import App from './App'
import Element from 'element-ui'
import 'normalize.css'
import '../node_modules/element-ui/lib/theme-default/index.css'

Vue.config.productionTip = true

Vue.use(Element)

/* eslint-disable no-new */
new Vue({
  el: '#app',
  template: '<App/>',
  components: { App }
})
