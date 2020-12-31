<template>
  <v-container class="fill-height">
    <v-row align="center" justify="center">
      <v-col cols="12" sm="8" md="4">
        <v-card class="elevation-8" :loading="card.loading">
          <div class="pt-12 pb-12 pl-6 pr-6">
            <v-btn  v-on='on' class="mb-2 ml-2" v-text="'移至管理者登入'" href="/login_admin"></v-btn>
            <v-img height="60" contain :src="require('../assets/logo.png')"></v-img>
            <v-card-title
              v-text="card.cardTitle"
              class="font-weight-black justify-center"
            ></v-card-title>
            <v-card-subtitle
              v-if="!card.chipShow"
              v-text="card.cardSubTitle"
              class="font-weight-black text-center mt-0 pa-3"
              style="margin-bottom: 2px;"
            ></v-card-subtitle>
            <v-row v-if="card.chipShow" justify="center" align="center">
              <v-chip class="ma-2" outlined >
                <v-icon
                  left
                  color="grey darken-2"
                  v-text="`mdi-account-circle`"
                ></v-icon>
                {{ user.username }} - {{ user.accountId }}
                <v-icon right v-text="`mdi-chevron-down`"></v-icon>
              </v-chip>
            </v-row>
            <!--transition :name="transitionName"-->
              <router-view
                :username.sync="user.username"
                :account-id.sync="user.accountId"
                :password.sync="user.password"
                :remove-mode.sync="card.removeMode"
                :loading.sync="card.loading"
              ></router-view>
            <!--/transition-->
            <!--v-overlay
              :absolute="card.overlay.absolute"
              :opacity="card.overlay.opacity"
              :value="card.loading"
              :color="card.overlay.color"
            >
            </v-overlay-->
          </div>
        </v-card>
      </v-col>
    </v-row>
  </v-container>
</template>

<script>
export default {
  name: "Login",
  props: ["accountId", "username"],
  data() {
    return {
      card: {
        cardTitle: "",
        cardSubTitle: "",                                                                                   
        chipShow: false,
        removeMode: false,
        //loading: false,
        overlay: {
          absolute: true,
          opacity: 0.3,
          color: "#FFF",
        },
      },
      user: {
        username: "",
        accountId: "",
        password: "",
      },
      transitionName: "",
    };
  },
  methods: {
    setCard(title, subTitle, chipShow) {
      this.card.cardTitle = title;
      this.card.cardSubTitle = subTitle;
      this.card.chipShow = chipShow;
    },
  },
  watch: {
    /*accountId: {
      handler(newValue, oldValue) {
        if (newValue) {
          this.user.accountId = newValue;
        }
      },
      immediate: true,
    },
    username: {
      handler(newValue, oldValue) {
        if (newValue) {
          this.user.username = newValue;
        }
      },
      immediate: true,
    },*/
    $route: {
      handler: function(to, from) {
        this.setCard("", "", false);
        //this.card.loading = true;
        this.transitionName = "slide-right";
        switch (to.name) {
          case "KeyinUser":
            this.setCard("使用者登入", "使用您的用戶帳戶");
            break;
        }
      },
      immediate: true,
    },
    /*"card.removeMode": {
      handler(newValue, oldValue) {
        if (newValue) {
          this.setCard("移除帳戶", "從這個瀏覽器中移除");
        } else {
          this.setCard("選擇帳戶");
        }
      },
    },*/
  },
};
/*:username.sync="user.username"
                :account-id.sync="user.accountId"
                :password.sync="user.password"
                :remove-mode.sync="card.removeMode"
                :loading.sync="card.loading"*/
</script>


<!--style scoped>
.slide-left-enter-active,
.slide-left-leave-active,
.slide-right-enter-active,
.slide-right-leave-active {
  transition: 0.5s;
}
.slide-left-enter,
.slide-right-leave-to {
  opacity: 0;
  transform: translate(100%);
  position: absolute;
}
.slide-right-enter,
.slide-left-leave-to {
  opacity: 0;
  transform: translate(-100%);
  position: absolute;
}
</style-->