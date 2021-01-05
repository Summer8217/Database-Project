<template>
  <div>
    <v-container>
      <div class="row">
        <p style="fontSize:27px">個人帳戶資訊： </p>
      </div>
      
      <div class="row pl-9" id ="app">
        <v-app id="inspire">
          <form>
            <div class="col-md-12 col-sm-12 col-xs-12" style="fontSize:22px">
              <span class="ensp">ID: </span>
              {{isID}}
            </div>
            <div class="col-md-12 col-sm-12 col-xs-12" style="fontSize:22px">
              <span class="ensp">Name: </span>
              {{isName}}
            </div>
            <div class="col-md-12 col-sm-12 col-xs-12" style="fontSize:22px">
              <span class="ensp">NickName: </span>
              {{isNickName}}
            </div>
            <!--div class="col-md-12 col-sm-12 col-xs-12" style="fontSize:24px">
              <span class="ensp">Address: </span>
              {{isAddress}}
            </div-->
            <!--div class="col-md-12 col-sm-12 col-xs-12" style="fontSize:24px">
              <span class="ensp">Phone Number: </span>
              {{isPhoneNumber}}
            </div-->
            <div class="col-md-12 col-sm-12 col-xs-12" style="fontSize:22px">
              <span class="ensp" >Email: </span>
              {{isEmail}}
            </div>
          </form>
        </v-app>
      </div>
    </v-container>
  </div>
</template>

<style scoped>
  .ensp:after {
    content: '\2002';
  }  
</style>

<script>
    import axios from 'axios'
    export default {
      name:"Profile",
      data() {
        return {
          isID: "",
          isName: "",
          isNickName: "",
          //isAddress: "",
          //isPhoneNumber: "",
          isEmail: ""
        };
      },
      methods: {
      },
      created(){
        var config={
            method: 'get',
            url: '/api/user',
            headers: {'Authorization': localStorage.getItem("accessToken")}
        };
        axios(config)
        .then((response)=>{
            this.isID = response.data.id;
            this.isName = response.data.name;
            this.isNickName = response.data.nickname;
            this.isEmail = response.data.email;
            console.log("sdfsdfsfdsdfaaa")
        })
        .catch(error => {
            console.log('4543423')
        });
      },
    }
</script>
