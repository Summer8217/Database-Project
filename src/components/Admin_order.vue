<template>
  <div>
    <v-container>
      <div class="row">
        <div class="col-md-12 col-sm-12 col-xs-12">
          <v-simple-table>
            <template v-slot:default>
              <thead>
              <tr>
                <th>Order_ID</th>
                <th>Shipping_Type</th>
                <th>Payment_Type</th>
                <th>Status</th>
                <th>Merchandise_Id</th>
                <th>Quantity</th>
                <th>Total_Price</th>
              </tr>
              </thead>
              <tbody>
              <tr>
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
                    v-model="MName"
                    ></v-text-field>
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
              </tr>
              </tbody>
            </template>
          </v-simple-table>
          <div class="col-md-12 col-sm-12 col-xs-12">
            <v-btn class="primary white--text" outlined tile dense v-on:click="passwordCheck">送出</v-btn>
          </div>
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