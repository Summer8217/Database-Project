<template>
  <div>
    <v-container>
      <div class="row">
        <div class="col-md-5 col-sm-5 col-xs-12">
          <v-carousel>
            <v-carousel-item
              :src="'data:image/png;base64, '+ image"
            >
            </v-carousel-item>

          </v-carousel>
        </div>
        <div class="col-md-7 col-sm-7 col-xs-12">
          <v-breadcrumbs class="pb-0" :items="breadcrums"></v-breadcrumbs>
          <div class="pl-6">
            <p class="display-1 mb-0">{{name}}</p>
            <v-card-actions class="pa-0">
              <p class="headline font-weight-light pt-3">${{price}}</p>
            </v-card-actions>
            <p class="subtitle-1">
              {{desc}}
            </p>
            <p class="title">ITEMS</p>

            <v-text-field
                outlined
                style="width:100px"
                v-bind:value="this.buyNum"
                dense
            ></v-text-field>
            <v-btn class="primary white--text" outlined tile dense @click="addShopCart"><v-icon>mdi-cart</v-icon> ADD TO CART</v-btn>

          </div>

        </div>
      </div>
      <div class="row">
        <div class="col-sm-12 col-xs-12 col-md-12">
          <v-tabs>
            <v-tab >Description</v-tab>
            <v-tab-item>
              <p class="pt-10 subtitle-1">
                {{desc}}
              </p>
            </v-tab-item>
          </v-tabs>
          <v-card-text
            class="pa-0 pt-4"
            tile
            outlined
          >
            <p class="subtitle-1 font-weight-light pt-3 text-center">YOU MIGHT ALSO LIKE</p>
            <v-divider></v-divider>
            <div class="row text-center">
              <div class="col-md-2 col-sm-4 col-xs-12 text-center" :key="pro.id" v-for="pro in products">
                <v-hover
                  v-slot:default="{ hover }"
                  open-delay="200"
                >
                  <v-card
                    :elevation="hover ? 16 : 2"
                  >
                    <v-img
                      class="white--text align-end"
                      height="200px"
                      :src="'data:image/png;base64, '+pro.image"
                    >
                      <v-card-title>{{pro.type}} </v-card-title>
                    </v-img>

                    <v-card-text class="text--primary text-center">
                      <div>{{pro.name}}</div>
                      <div>${{pro.price}}</div>
                    </v-card-text>

                    <div class="text-center">
                      <v-btn
                        class="ma-2"
                        outlined
                        color="info"
                        :href="'../product/'+pro.id"
                      >
                        Explore
                      </v-btn>
                    </div>
                  </v-card>
                </v-hover>
              </div>
            </div>
          </v-card-text>
        </div>
      </div>
    </v-container>
    <v-card  class="accent" >
      <v-container>
        <v-row no-gutters>
          <v-col class="col-12 col-md-4 col-sm-12">
            <v-row >
              <v-col class="col-12 col-sm-3 pr-4 hidden-sm-only" align="right">
                <v-icon class="display-2">mdi-truck</v-icon>
              </v-col>
              <v-col class="col-12 col-sm-9 pr-4">
                <h3 class="font-weight-light">FREE SHIPPING & RETURN</h3>
                <p class="font-weight-thin">Free Shipping over $300</p>
              </v-col>
            </v-row>
          </v-col>
          <v-col class="col-12 col-md-4 col-sm-12">
            <v-row >
              <v-col class="col-12 col-sm-3 pr-4" align="right">
                <v-icon class="display-2">mdi-cash-usd</v-icon>
              </v-col>
              <v-col  class="col-12 col-sm-9 pr-4">
                <h3 class="font-weight-light">MONEY BACK GUARANTEE</h3>
                <p class="font-weight-thin">30 Days Money Back Guarantee</p>
              </v-col>
            </v-row>
          </v-col>
          <v-col class="col-12 col-md-4 col-sm-12">
            <v-row>
              <v-col class="col-12 col-sm-3 pr-4" align="right">
                <v-icon class="display-2">mdi-headset</v-icon>
              </v-col>
              <v-col  class="col-12 col-sm-9 pr-4">
                <h3 class="font-weight-light">020-800-456-747</h3>
                <p class="font-weight-thin">24/7 Available Support</p>
              </v-col>
            </v-row>
          </v-col>
        </v-row>
      </v-container>
    </v-card>
  </div>
</template>

<script>
    import axios from 'axios'
    export default {
        data: () => ({
            name:'',
            image:'',
            desc:'',
            price:0,
            breadcrums: [
                {
                    text: 'Home',
                    disabled: false,
                    href: '/',
                },
                {
                    text: 'Shop',
                    disabled: false,
                    href: '/shop',
                },
                {
                    text: '',
                    disabled: true,
                },
            ],
            products:[]
        }),
        methods:{
          addShopCart(){
            var config={
              method: 'post',
              url: '/api/add-to-cart',
              headers: {'Authorization': localStorage.getItem("accessToken")},
              data: {merchandise_id: this.$route.query.id , quantity: this.buyNum}
            };
            axios(config).then((response=>{

            }))
          }
        },
        mounted: function(){
          axios.get('/api/merchandise/'+ this.$route.params.id)
          .then(response =>{
            console.log(response.data);
            this.name = response.data.name;
            document.title='Byson - ' + this.name;
            this.breadcrums[2].text = response.data.merchandise_type;
            this.image = response.data.image;
            this.desc = response.data.detail_info;
            this.price = response.data.price;
            console.log(this.price);
          })
          .catch(error => {
            console.log(error)
          }),
          axios.get("/api/get-all")
          .then(response => {
            this.products = response.data.products.slice(0, 6);
            console.log(this.products)
          })
          .catch(error => {
            console.log(error)
          })
        },
    }
</script>
