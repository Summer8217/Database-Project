<template>
  <div>
    <v-container>
      <div class="row">
        <p style="fontSize:24px">請輸入以下資訊註冊帳號： </p>
      </div>
      <div class="row pl-9">
        <div class="col-md-12 col-sm-12 col-xs-12">
          <span>Name: </span>
          <v-text-field
          label = "輸入你的名字"
          type = "text"
          class = "font-weight-bold"
          outlined
          clearable
          v-model="registerName"
          ></v-text-field>
        </div>
        <div class="col-md-12 col-sm-12 col-xs-12">
          <span>NickName: </span>
          <v-text-field
          label = "輸入你的暱稱"
          type = "text"
          class = "font-weight-bold"
          outlined
          clearable
          v-model="registerNickName"
          ></v-text-field>
        </div>
        <div class="col-md-12 col-sm-12 col-xs-12">
          <span>Address: </span>
          <v-text-field
          label = "輸入你的地址"
          type = "text"
          class = "font-weight-bold"
          outlined
          clearable
          v-model="registerAddress"
          ></v-text-field>
        </div>
        <div class="col-md-12 col-sm-12 col-xs-12">
          <span>Phone Number: </span>
          <v-text-field
          label = "輸入你的電話號碼"
          type = "text"
          class = "font-weight-bold"
          outlined
          clearable
          v-model="registerPhoneNumber"
          ></v-text-field>
        </div>
        <div class="col-md-12 col-sm-12 col-xs-12">
          <span>Email: </span>
          <v-text-field
          label = "輸入你的電子郵件信箱"
          type = "text"
          class = "font-weight-bold"
          outlined
          clearable
          v-model="registerName"
          ></v-text-field>
        </div>
        <div class="col-md-12 col-sm-12 col-xs-12">
          <span>AccountID </span>
          <v-text-field
          label = "輸入你的帳號"
          type = "text"
          class = "font-weight-bold"
          outlined
          clearable
          v-model="registerID"
          ></v-text-field>
        </div>
        <div class="col-md-12 col-sm-12 col-xs-12">
          <span>Password </span>
          <v-text-field
          label = "輸入你的密碼"
          type = "text"
          class = "font-weight-bold"
          outlined
          clearable
          v-model="registerPassword"
          ></v-text-field>
        </div>
        <div class="col-md-12 col-sm-12 col-xs-12">
          <span>CheckPassword </span>
          <v-text-field
          label = "確認密碼"
          type = "text"
          class = "font-weight-bold"
          outlined
          clearable
          v-model="registerPasswordCheck"
          :rules="checkPasswordRule"
          ></v-text-field>
        </div>
        <div class="col-md-12 col-sm-12 col-xs-12">
          <v-btn class="primary white--text" outlined tile dense v-on:click="passwordCheck"> Register!</v-btn>
        </div>
      </div>
    </v-container>
  </div>
</template>

<script>
  import axios from 'axios'
    export default {
      name:"Register",
    data() {
      return {
        textFieldError: true,
        errorMessages: "密碼輸入不一致",
        checkPasswordRule: [
          (v) => !!v || "請確認密碼",
          (v) => (this.registerPasswordCheck === this.registerPassword) || "密碼不一致",
          (v) => this.textFieldError || this.errorMessages,
        ],
      };
  },
      
    }
</script>
