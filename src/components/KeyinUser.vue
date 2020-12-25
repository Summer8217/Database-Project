<template>
  <v-form ref="form" @submit.prevent>
    <v-card-text>
      <v-text-field
        label = "輸入你的帳號"
        type = "text"
        class = "font-weight-bold"
        outlined
        clearable
        v-model="myAccountId"
        :rules="usernameRules"
        :counter="usernameLength"
        @keyup="setTextFieldError(true, '')"
        @keyup.enter.prevent="verifyUser"
      ></v-text-field>
      <!--v-text-field
        ref="eleAccountId"
      ></v-text-field-->
    </v-card-text>
    <v-card-actions>
      <v-spacer><v-btn  class="mr-2" v-text="'沒有帳戶，註冊?'"></v-btn></v-spacer>
      <v-btn color="primary" class="mr-2" v-text="'繼續'" v-on:click="verifyUser">
      </v-btn>
    </v-card-actions>
  </v-form>
</template>

<script>
export default {
  name: "KeyinUser",
  props: ["accountId"],
  data() {
    return {
      textFieldError: true,
      errorMessages: "",
      usernameLength: 10,
      usernameRules: [
        (v) => !!v || "請輸入帳號",
        (v) => (v && v.length <= this.usernameLength) || "最多10碼",
        (v) => this.textFieldError || this.errorMessages,
      ],
      fakedata:{
        accountId: "asd123", //假帳
        username: "Nick Good",
      },
    };
  },
  methods: {
    verifyUser: function() {
      if (this.$refs.form.validate()) {
        if (this.myAccountId == this.fakedata.accountId) {
          this.$emit("update:username", this.fakedata.username);
          this.$router.push({ name: "KeyinPswd" }); //如果帳號成功，要做的事
          //alert('submit!');
        } else {
          this.setTextFieldError(false, "帳號錯誤"); //如果帳號失敗，要做的事
          alert('Not submit!');
        }
      }
    },
        /*const api = `${process.env.VUE_APP_APIPATH}/users/accountid/${this.myAccountId}`;
        this.$http({
          method: "GET",
          url: api,
        })
          .then((response) => {
            if (response.data.success) {
              this.$emit("update:username", response.data.username);
              this.$router.replace({ name: "KeyinPswd" });
            } else {
              this.setTextFieldError(false, response.data.message);
              this.$refs.form.validate();
            }
          })
          .catch((error) => {
            this.setTextFieldError(false, error);
            this.$refs.form.validate();
          });
      }
    },*/
    setTextFieldError(textFieldError, errorMessages) {
      this.textFieldError = textFieldError;
      this.errorMessages = errorMessages;
    },
  },
  computed: {
    myAccountId: {
      get() {
        return this.accountId;
      },
      set(value) {
        this.$emit("update:accountId", value);
      },
    },
  },
  /*watch: {
    loading: {
      handler(newValue, oldValue) {
        if (newValue) {
          setTimeout(() => {
            this.$emit("update:loading", false);
          }, 1000);
        } else {
          this.$refs.eleAccountId.focus();
        }
      },
      immediate: true,
    },
  },*/
};
</script>
