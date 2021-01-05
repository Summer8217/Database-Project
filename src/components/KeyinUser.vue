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
      <v-text-field
        label="輸入您的密碼"
        :type="showpswd ? 'text' : 'password'"
        class="font-weight-bold"
        outlined
        clearable
        :rules="passwordRules"
        :counter="passwordLength"
        v-model="myPassword"
        :append-icon="showpswd ? 'mdi-eye' : 'mdi-eye-off'"
        @click:append="showpswd = !showpswd"
        @keyup="setTextFieldError(true, '')"
        @keyup.enter.prevent="verifyUser"
      ></v-text-field>
      <!--v-text-field
        ref="eleAccountId"
      ></v-text-field-->
    </v-card-text>
    <v-card-actions>
      <v-spacer><v-btn  class="mr-2" v-text="'沒有帳戶，註冊?'" href="/register"></v-btn></v-spacer>
      <v-btn color="primary" class="mr-2" v-text="'繼續'" v-on:click="verifyUser">
      </v-btn>
    </v-card-actions>
  </v-form>
</template>

<script>
import axios from 'axios' 
export default {
  name: "KeyinUser",
  props: ["accountId", "password","isLogin"],
  data() {
    return {
      textFieldError: true,
      errorMessages: "",
      //usernameLength: 10,
      usernameRules: [
        (v) => !!v || "請輸入帳號",
        //(v) => (v && v.length <= this.usernameLength) || "最多10碼",
        (v) => this.textFieldError || this.errorMessages,
      ],
      showpswd: false,
      passwordRules: [
        (v) => !!v || "請輸入密碼",
        (v) => this.textFieldError || this.errorMessages,
      ],
      fakedata:{
        accountId: "asd123", //假帳
        username: "Nick Good",
        password: "123456",
      },
    };
  },
  methods: {
    verifyUser: function(){
       var bodyFormData = new FormData();
      bodyFormData.append('email', this.myAccountId);
      bodyFormData.append('password', this.myPassword);
      var config = {
        method: 'post',
        url: 'http://localhost:3000/login',
        data: bodyFormData,
        headers: {'Content-Type': 'multipart/form-data' }
      };
      axios(config)
      .then((response) => {
        if (response.data.message=="successful") {
          //this.$emit("update:name", response.data.name);
          localStorage.setItem("accessToken",response.data.token);
          this.$router.push({ name: "Home"});
          alert("登入成功");
          location.reload();
        } else {
          this.setTextFieldError(false, response.data.message);
          this.$refs.form.validate();
          alert("登入失敗")
        }
      })
      .catch((error) => {
        this.setTextFieldError(false, error);
        this.$refs.form.validate();
      });
      
    },
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
    myPassword: {
      get() {
        return this.password;
      },
      set(value) {
        this.$emit("update:password", value);
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