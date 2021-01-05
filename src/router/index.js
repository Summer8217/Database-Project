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
import Login_admin from '@/components/Login_admin'
import KeyinUser_admin from '@/components/KeyinUser_admin'
import Admin_home from '@/components/Admin_home'
import Admin_user from '@/components/Admin_user'
import Admin_merchandise from '@/components/Admin_merchandise'
import Admin_order from '@/components/Admin_order'
import Order from '@/components/Order'
import SearchResult from '@/components/SearchResult'
import User from '@/components/User'
import Profile from '@/components/Profile'
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
          path:'/product/:id',
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
          path:'/order',
          component:Order,
          name:'Order'         
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
          ]
        },
        {
          path:'/search',
          component:SearchResult,
          props:true,
          name:'SearchResult',
        },
        {
          path:'/user',
          component:User,
          props:true,
          name:'User',
        },
        {
          path:'/profile',
          component:Profile,
          name:'Profile',
        }
      ]
    },
    {
      path:'/',
      component:Admin_home,
      name:'Admin_home',
   //   redirect:{name:'Admin_merchandise'},
      children:[
        {
          path:'admin_merchandise',
          component:Admin_merchandise,
          name:'Admin_merchandise'
        },
        {
          path:'admin_user',
          component:Admin_user,
          name:'Admin_user'
        },
        {
          path:'admin_order',
          component:Admin_order,
          name:'Admin_order'
        }
      ]
    },
    
  ],
    mode:'history'
},

  )
