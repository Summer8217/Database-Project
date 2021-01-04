<template>
  <v-app id="inspire">
    <v-app-bar
      :clipped-left="$vuetify.breakpoint.lgAndUp"
      app
      color="primary"
      dark
    >
      <v-toolbar-title
        style="width: 430px"
      >
        <a class="white--text" style="text-decoration: none"><v-icon>mdi-truck</v-icon>&nbsp;Byson-Admin</a>
      </v-toolbar-title>
      <v-spacer />
      <v-btn v-on:click="judge" icon>
        {{isLogin}}
      </v-btn>
    </v-app-bar>
    <v-content>
      <v-bottom-navigation
        :value="activeBtn"
        color="primary"
        horizontal
      >
        <v-btn href="/admin_user">
          <span>用戶管理</span>
        </v-btn>
        <v-btn href="/admin_merchandise">
          <span>商品管理</span>
        </v-btn>
        <v-btn href="/admin_order" >
          <span>訂單管理</span>
        </v-btn>
      </v-bottom-navigation>
      <router-view/>
    </v-content>
  </v-app>
</template>

<script>
export default {
  data(){
    isLogin = ""
  },
  methods:{
    judge: function(){
      if(localStorage.getItem("accessToken") != null){
        alert("已登出");
        this.$router.push({ name: "Home" });
        this.isLogin = "登入"
        localStorage.removeItem("accessToken");
      }
      else{
        this.$router.push({ name: "Login" });
        this.isLogin = "登出"
      }
        
    }
  },
  created() {
    if(localStorage.getItem("accessToken") != null){
        this.isLogin = "登出";
    }
    else{
      this.isLogin = "登入";
    }
  },
};
</script>