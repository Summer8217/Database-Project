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
import Login_admin from '@/components/Login_admin'
import KeyinUser_admin from '@/components/KeyinUser_admin'
import KeyinPswd_admin from '@/components/KeyinPswd_admin'
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
        },
        {
          path:'/login_admin',
          component:Login_admin,
          name:'Login_admin',
          redirect:{name:'KeyinUser_admin'},
          children:[
            {
              path:'keyinUser_admin',
              component:KeyinUser_admin,
              name:'KeyinUser_admin'
            },
            {
              path:'keyinPswd_admin',
              component:KeyinPswd_admin,
              name:'KeyinPswd_admin'
            }
          ]
        }
      ]

    }
  ],
    mode:'history'
},

  )
