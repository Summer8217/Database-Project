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
                <th>ITEM_TYPE</th>
                <th>PRICE</th>
                <th>QUANTITY</th>
              </tr>
              </thead>
              <tbody>
                <tr>
                  <td>
                      <input type="file" accept="image/*" @change="uploadImage" id="MImage">
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
                      v-model="MType"
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
            <v-btn class="primary white--text" outlined tile dense v-on:click="onUploadChange">送出</v-btn>
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
      data(){
        return{
          selectedImage:null,
          image:null
        }
      },
      methods: {
        uploadImage(event){
          this.selectedImage = event.target.files[0];
          const reader = new FileReader(); //建立FileReader 監聽 Load 事件
          reader.addEventListener('load',this.imageLoader);
          reader.readAsDataURL(this.selectedImage);
        },
        imageLoader(event){
          this.image=event.target.result;
        },
        onUploadChange:function() {
            var dataForm = new FormData();
            dataForm.append('MerchandiseImage', this.image);  //blob
            dataForm.append('MerchandiseName', this.MName);
            dataForm.append('MerchandiseDescription', this.MDescription);
            dataForm.append('MerchandiseType', this.MType);
            dataForm.append('MerchandisePrice', this.MPrice);
            dataForm.append('MerchandiseQuantity', this.MQuantity);
            console.log(this.image);
            var config = {
              method:'post',
              url:'/api/add-merchandise',
              data:dataForm,
              headers:{'Content-Type': 'multipart/form-data','Authorization': localStorage.getItem("accessToken")}
            };
            axios(config)
              .then(function (response) {
                alert("加入商品成功!");
                window.location="/Admin_merchandise";
              })
              .catch(function (response) {
              })
        },
        onUploadRemove: async function() {
            this.picBase64 = null;
        },
      }
    }
</script>
