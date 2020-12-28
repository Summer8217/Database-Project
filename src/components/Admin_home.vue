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
    </v-content>
      <router-view/>
  </v-app>
</template>

<script>
export default {
};
</script>