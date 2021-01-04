<template>
  <div>
    <v-container>
      <div class="row">
        <p style="fontSize:24px">請輸入以下資訊註冊帳號： </p>
      </div>
      
      <div class="row pl-9" id ="app">
        <v-app id="inspire">
          <form>
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
              v-model="registerEmail"
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
              type="password"
              class = "font-weight-bold"
              outlined
              clearable
              v-model="registerPassword"
              ref="password"
              v-validate="'required'"
              :error-messages="sss"
              required
              data-vv-name="pass"
              ></v-text-field>
            </div>
            <div class="col-md-12 col-sm-12 col-xs-12">
              <span>CheckPassword </span>
              <v-text-field
              label = "確認密碼"
              type="password"
              v-validate="'required|confirmed:password'"
              :error-messages="qeqwe"
              class = "font-weight-bold"
              outlined
              clearable
              required
              v-model="registerPasswordCheck"
              :rules="checkPasswordRule"
              data-vv-name="pass"
              ></v-text-field>
            </div>
            <div class="col-md-12 col-sm-12 col-xs-12">
              <v-btn class="primary white--text" outlined tile dense v-on:click="passwordCheck"> Register!</v-btn>
            </div>
          </form>
        </v-app>
      </div>
    </v-container>
  </div>
</template>

<script>
    import axios from 'axios'
    export default {
      name:"Register",
      data() {
        errors = [],
        registerPasswordCheck=null,
        registerPassword=null
        return {
          textFieldError: true,
          errorMessages: "密碼輸入不一致",
          checkPasswordRule: [
            (v) => !!v || "請確認密碼",
            (v) => (this.registerPasswordCheck == this.registerPassword) || "密碼不一致",
            (v) => this.textFieldError || this.errorMessages,
          ],
        };
      },
      methods: {
        passwordCheck: function() {
          this.errors = [];
          if(!this.registerPassword){
            this.errors.push('password required');
          }
          if(!this.registerName){
            this.errors.push('Name required');
          }
          if(this.registerPasswordCheck !== this.registerPassword){
            this.errors.push('comfirm password failed');
          }
          if(!this.registerEmail){
            this.errors.push('Email required');
          }
          if(!this.registerID){
            this.errors.push('ID required');
          }
          if(!this.registerPhoneNumber){
            this.errors.push('Phone Number required');
          }
          if(this.errors.length == 0){
            var postForm = new FormData();
            postForm.append("MemberName",this.registerName);
            postForm.append("MemberNickName",this.registerNickName);
            postForm.append("MemberAddress",this.registerAddress);
            postForm.append("MemberPhone",this.registerPhoneNumber);
            postForm.append("MemberEmail",this.registerEmail);
            postForm.append("MemberPassword",this.registerPassword);
            var config = {
              method:'post',
              url:'http://localhost:3000/register',
              data:postForm,
              headers:{'Content-Type': 'multipart/form-data'}
            };
            axios(config)
              .then(function (response) {
                  if(response.status=="200"){
                    if(confirm("註冊成功") || !confirm("註冊成功")){
                      window.location="/login";
                    }
                  }
              })
              .catch(function (response) {
                  //handle error
                  alert('此電子郵件已註冊過會員');
              })
          }else{
            alert(JSON.stringify(this.errors));
          }
        },
      }
    }
</script>
