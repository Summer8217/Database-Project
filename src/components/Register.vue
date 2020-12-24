<template>
  <div>
    <v-container>
      <div class="row ">
        <p style="font-weight-light">請輸入以下資訊註冊帳號： </p>
      </div>
      <div class="row pl-9">
        <div class="col-md-12 col-sm-12 col-xs-12">
          <span class="pr-3">Name: </span>
          <input v-model="registerName" placeholder="input here">
        </div>
        <div class="col-md-12 col-sm-12 col-xs-12">
          <span class="pr-3">NickName: </span>
          <input v-model="registerNickName" placeholder="input here">
        </div>
        <div class="col-md-12 col-sm-12 col-xs-12">
          <span class="pr-3">Address: </span>
          <input v-model="registerAddress" placeholder="input here">
        </div>
        <div class="col-md-12 col-sm-12 col-xs-12">
          <span class="pr-3">Phone: </span>
          <input v-model="registerPhone" placeholder="input here">
        </div>
        <div class="col-md-12 col-sm-12 col-xs-12">
          <span class="pr-3">Email: </span>
          <input v-model="registerEmail" placeholder="input here">
        </div>
        <div class="col-md-12 col-sm-12 col-xs-12">
          <span class="pr-3">Account: </span>
          <input v-model="registerAccount" placeholder="input here">
        </div>
        <div class="col-md-12 col-sm-12 col-xs-12">
          <span class="pr-3">Password: </span>
          <input v-model="registerPassword" placeholder="input here">
        </div>
        <div class="col-md-12 col-sm-12 col-xs-12">
          <span class="pr-3">Check Password: </span>
          <input v-model="registerCheckPassword" placeholder="input here">
        </div>
        <div class="col-md-12 col-sm-12 col-xs-12">
          <v-btn class="primary white--text" outlined tile dense> Register!</v-btn>
        </div>
      </div>
    </v-container>
  </div>
</template>
<script>
    export default {
        data: () => ({
            rating:4.5,
            breadcrums: [
                {
                    text: 'Home',
                    disabled: false,
                    href: 'breadcrumbs_home',
                },
                {
                    text: 'Clothing',
                    disabled: false,
                    href: 'breadcrumbs_clothing',
                },
                {
                    text: 'T-Shirts',
                    disabled: true,
                    href: 'breadcrumbs_shirts',
                },
            ],
        }),
    }
</script>
