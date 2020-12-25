import Vue from 'vue'
import Router from 'vue-router'
import Home from '@/components/Home'
import Shop from '@/components/Shop'
import Product from '@/components/Product'
import Blog from '@/components/Blog'
import Post from '@/components/Post'
import Cart from '@/components/Cart'
import Layout from '@/components/Layout'
import Register from '@/components/Register'
import Login from '@/components/Login'
import KeyinUser from '@/components/KeyinUser'
import KeyinPswd from '@/components/KeyinPswd'
Vue.use(Router)

export default new Router({
  routes: [
    {
      path: '/',
      component: Layout,
      children:[
        {
          path:'/',
          component:Home,
          name:'Home'
        },
        {
          path:'/shop',
          component:Shop,
          name:'Shop'
        },
        {
          path:'/product',
          component:Product,
          name:'Product'
        },
        {
          path:'/blog',
          component:Blog,
          name:'Blog'
        },
        {
          path:'/post',
          component:Post,
          name:'Post'
        },
        {
          path:'/cart',
          component:Cart,
          name:'Cart'
        },
        {
          path:'/register',
          component:Register,
          name:'Register'
        },
        {
          path:'/login',
          component:Login,
          name:'Login',
          redirect:{name:'KeyinUser'},
          children:[
            {
              path:'keyinUser',
              component:KeyinUser,
              name:'KeyinUser'
            },
            {
              path:'keyinPswd',
              component:KeyinPswd,
              name:'KeyinPswd'
            }
          ]
        }
      ]

    }
  ],
    mode:'history'
},

  )
