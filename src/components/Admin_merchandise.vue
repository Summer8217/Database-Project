<template>
  <div>
    <v-container>
      <div class="row">
        <div class="col-md-12 col-sm-12 col-xs-12">
          <v-simple-table>
            <template v-slot:default>
              <thead>
              <tr>
                <th>ITEM_PHOTO</th>
                <th>ITEM_NAME</th>
                <th>ITEM_DESCRIPTION</th>
                <th>PRICE</th>
                <th>QUANTITY</th>
              </tr>
              </thead>
              <tbody>
              <tr>
                <td>
                    <input type="file" accept="image/*" @change="uploadImage($event)" id="file-input">
                </td>
                <td>
                    <v-text-field
                    type = "text"
                    class = "font-weight-bold"
                    outlined
                    clearable
                    v-model="MName"
                    ></v-text-field>
                </td>
                <td>
                    <v-text-field
                    type = "text"
                    class = "font-weight-bold"
                    outlined
                    clearable
                    v-model="MDescption"
                    ></v-text-field>
                </td>
                <td>
                    <v-text-field
                    type = "text"
                    class = "font-weight-bold"
                    outlined
                    clearable
                    v-model="MPrice"
                    ></v-text-field>
                </td>
                <td>
                    <v-text-field
                    type = "text"
                    class = "font-weight-bold"
                    outlined
                    clearable
                    v-model="MQuantity"
                    ></v-text-field>
                </td>
              </tr>
              </tbody>
            </template>
          </v-simple-table>
          <div class="col-md-12 col-sm-12 col-xs-12">
            <v-btn class="primary white--text" outlined tile dense v-on:click="passwordCheck">送出</v-btn>
          </div>
          <v-simple-table class="mb-3">
            <template v-slot:default>
              <tbody>
              <tr>
                <td>
                    <v-img 
                      class="align-end"
                      height="150px"
                      width="150px"
                      :src="require('../assets/img/home/deal1.jpg')"
                    ></v-img>
                </td>
                <td>
                  <p class="pt-10 subtitle-1">
                    超讚吸塵器
                  </p>
                </td>
                <td>
                  <p class="pt-10 subtitle-1">
                    真的很讚
                  </p>
                </td>
                <td>
                  <p class="pt-10 subtitle-1">
                    NT3,000
                  </p>
                </td>
                <td>
                  <p class="pt-10 subtitle-1">
                    2020
                  </p>
                </td>
              </tr>
              </tbody>
            </template>
          </v-simple-table>
          <v-simple-table class="mb-3">
            <template v-slot:default>
              <tbody>
              <tr>
                <td>
                    <v-img 
                      class="align-end"
                      height="150px"
                      width="150px"
                      :src="require('../assets/img/home/deal3.jpg')"
                    ></v-img>
                </td>
                <td>
                  <p class="pt-10 subtitle-1">
                    猛的吹風機
                  </p>
                </td>
                <td>
                  <p class="pt-10 subtitle-1">
                    也是很讚
                  </p>
                </td>
                <td>
                  <p class="pt-10 subtitle-1">
                    NT1,700
                  </p>
                </td>
                <td>
                  <p class="pt-10 subtitle-1">
                    2021
                  </p>
                </td>
              </tr>
              </tbody>
            </template>
          </v-simple-table>
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
            (v) => (this.registerPasswordCheck == this.registerPassword) || "密碼不一致",
            (v) => this.textFieldError || this.errorMessages,
          ],
        };
      },
      methods: {
        passwordCheck: function() {
          if ((this.registerPassword == this.registerPasswordCheck)) {
            alert('register success!');
          }else{
            alert('asdasd');
          }
        },
        onUploadChange: async function(file) {
            const isIMAGE =
                file.raw.type === "image/jpeg" || file.raw.type === "image/png";//判別格式
            const isLt1M = file.size / 1024 / 1024 < 500000;//判別大小
            if (!isIMAGE) {
                this.$message.error("只能上傳jpg,png格式");
                return false;
            }
            if (!isLt1M) {
                this.$message.error("上傳圖片大小不能大於5MB");
                return false;
            }
            this.picBase64 = await setBase64(file); //這邊將base64存入變數(setBase64()額外實作)
        },
        onUploadRemove: async function() {
            this.picBase64 = null;
        },
      }
    }
</script>
