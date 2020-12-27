<template>
  <v-form ref="form" @submit.prevent>
    <v-card-text>
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
        @keyup.enter.prevent="verifyPswd"
      ></v-text-field>
      <!--v-text-field
        ref="elePassword"
        label="輸入您的密碼"
        :type="showpswd ? 'text' : 'password'"
        class="font-weight-bold"
        outlined
        clearable
        :rules="passwordRules"
        :counter="passwordLength"
        :append-icon="showpswd ? 'mdi-eye' : 'mdi-eye-off'"
        v-model="myPassword"
        @keyup="setTextFieldError(true, '')"
        @keyup.enter.prevent="verifyPswd"
        @click:append="showpswd = !showpswd"
      ></v-text-field-->
    </v-card-text>
    <v-card-actions>
      <v-spacer></v-spacer>
      <v-btn color="primary" class="mr-2" v-text="`繼續`" @click="verifyPswd">
      </v-btn>
    </v-card-actions>
  </v-form>
</template>
<script>
export default {
  name: "KeyinPswd_admin",
  props: ["password"],
  data() {
    return {
      textFieldError: true,
      errorMessages: "",
      passwordLength: 15,
      showpswd: false,
      passwordRules: [
        (v) => !!v || "請輸入密碼",
        (v) => this.textFieldError || this.errorMessages,
      ],
      fakedata:{
        password: "654321",
      },
    };
  },
  methods: {
    verifyPswd() {
      if (this.$refs.form.validate()) {
        if (this.myPassword === this.fakedata.password) {
          this.$router.push({ name: "Home" });
          alert("Succeed");
        } else {
        this.setTextFieldError(false, "密碼錯誤");
        }
      }
    
      /*if (this.$refs.form.validate()) {
        const api = `${process.env.VUE_APP_APIPATH}/users/signin`;
        this.$http({
          method: "POST",
          url: api,
          data: { accountId: this.accountId, password: this.password },
        })
          .then((response) => {
            if (response.data.success) {
              this.$router.push({ name: "Index" });
            } else {
              this.setTextFieldError(false, response.data.message);
              this.$refs.form.validate();
            }
          })
          .catch((error) => {
            this.setTextFieldError(false, error);
          });
      }*/
    },
    setTextFieldError(textFieldError, errorMessages) {
      this.textFieldError = textFieldError;
      this.errorMessages = errorMessages;
    },
  },
  computed: {
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
          this.$refs.elePassword.focus();
        }
      },
      immediate: true,
    },
  },*/
};
</script>
