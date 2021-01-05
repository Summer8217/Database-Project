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
                <form>
                  <tr>
                    <td>
                        <input type="file" accept="image/*" @change="uploadImage($event)" id="MImage">
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
                </form>
              </tbody>
            </template>
          </v-simple-table>
          <div class="col-md-12 col-sm-12 col-xs-12">
            <v-btn class="primary white--text" outlined tile dense v-on:click="uploadMerchandise">送出</v-btn>
          </div>
        </div>
        
      </div>
    </v-container>
  </div>
</template>

<script>
    import axios from 'axios'
    export default {
      name:"Admin_merchandise",
      methods: {
        onUploadChange: async function(file) {
            var dataForm = new FormData();
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
            dataForm.append('file', event.target.files[0]);
            dataForm.append('MerchandiseName', this.MName);
            dataForm.append('MerchandiseDescription', this.MDescription);
            dataForm.append('MerchandisePrice', this.MPrice);
            dataForm.append('MerchandiseQuantity', this.MQuantity);
            var config = {
              method:'post',
              url:'http://localhost:3000/Admin_merchandise',
              data:dataForm,
              headers:{'Content-Type': 'multipart/form-data'}
            };
        },
        onUploadRemove: async function() {
            this.picBase64 = null;
        },
      }
    }
</script>
