<template>
  <v-app id="inspire">
    <v-app-bar
      :clipped-left="$vuetify.breakpoint.lgAndUp"
      app
      color="primary"
      dark
    >
<!--      <v-app-bar-nav-icon @click.stop="drawer = !drawer" />-->

      <v-toolbar-title
        style="width: 430px"
      >
        <a href="/" class="white--text" style="text-decoration: none"><v-icon>mdi-truck</v-icon>&nbsp;Byson</a>
      </v-toolbar-title>
      <v-text-field
        flat
        solo-inverted
        v-model="keyword"
        hide-details
        prepend-inner-icon="mdi-magnify"
        label="Search"
        class="hidden-sm-and-down pl-10 ml-4"
        @keydown.enter="search(keyword)"
      />
      <v-spacer />
      <v-btn @click="judge()" icon>
        {{isLogin}}
      </v-btn>
      <v-btn v-on="on" href="/cart" icon>
        <v-icon>mdi-cart</v-icon>
      </v-btn>
    </v-app-bar>
    <v-content>
      <v-bottom-navigation
        :value="activeBtn"
        color="primary"
        horizontal
      >
        <a href="/" class="v-btn">
          <span>Home</span>
        </a>
        <a href="/shop" class="v-btn">
          <span>Shop</span>
        </a>
      </v-bottom-navigation>
    </v-content>
      <router-view/>
    <v-footer
      :padless="true"
    >
      <v-card
        flat
        tile
        width="100%"
        class="secondary white--text text-center"
      >
        <v-card-text>
          <v-btn
            class="mx-4 white--text"
            icon
          >
            <v-icon size="24px">mdi-home</v-icon>
          </v-btn>
          <v-btn
            class="mx-4 white--text"
            icon
          >
            <v-icon size="24px">mdi-email</v-icon>
          </v-btn>
          <v-btn
            class="mx-4 white--text"
            icon
          >
            <v-icon size="24px">mdi-calendar</v-icon>
          </v-btn>
           <v-btn
            class="mx-4 white--text"
            icon
          >
            <v-icon size="24px">mdi-delete</v-icon>
          </v-btn>

        </v-card-text>

        <v-card-text class="white--text pt-0">
          Phasellus feugiat arcu sapien, et iaculis ipsum elementum sit amet. Mauris cursus commodo interdum. Praesent ut risus eget metus luctus accumsan id ultrices nunc. Sed at orci sed massa consectetur dignissim a sit amet dui. Duis commodo vitae velit et faucibus. Morbi vehicula lacinia malesuada. Nulla placerat augue vel ipsum ultrices, cursus iaculis dui sollicitudin. Vestibulum eu ipsum vel diam elementum tempor vel ut orci. Orci varius natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus.
        </v-card-text>

        <v-divider></v-divider>

        <v-card-text class="white--text">
          {{ new Date().getFullYear() }} — <strong>Byson</strong>
        </v-card-text>
      </v-card>
    </v-footer>
  </v-app>
</template>
<script>
    export default {
        data () {
            return {
                activeBtn: 1,
                isLogin: ""
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
        methods: {
          search(keyword) {
            console.log('search:' + keyword);
            this.$router.push({path:'/search', query:{keyword:keyword}});
          },
          judge(){
            console.log("in")
            if(localStorage.getItem("accessToken") != null){
              alert("已登出");
              this.$router.push({ name: "Home" });
              this.isLogin = "登入"
              localStorage.removeItem("accessToken");
            }
            else{
              this.$router.push({ name: "Login" });
            }  
          },
          login(){
            this.$router.push({name:'Login'});
          }
        },
    }
</script>

