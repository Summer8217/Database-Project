<template>
  <div>
    <v-container>
      <div class="row">
        <div class="col-md-5 col-sm-5 col-xs-12">
          <v-carousel>
<<<<<<< HEAD
            <div v-for="img in image" :key="img.src">
              <v-carousel-item
              :src="`/static/img/shop/${img.src}`"
              >
              </v-carousel-item>
            </div>
=======
            <v-carousel-item
              :src="'data:image/png;base64, '+ image"
            >
            </v-carousel-item>

>>>>>>> yang
          </v-carousel>
        </div>
        <div class="col-md-7 col-sm-7 col-xs-12">
          <v-breadcrumbs class="pb-0" :items="breadcrums"></v-breadcrumbs>
          <div class="pl-6">
<<<<<<< HEAD
            <p class="display-1 mb-0">Honeywell 空氣清淨機</p>
=======
            <p class="display-1 mb-0">{{name}}</p>
>>>>>>> yang
            <v-card-actions class="pa-0">
              <p class="headline font-weight-light pt-3">${{price}}</p>
            </v-card-actions>
<<<<<<< HEAD
=======
            <p class="subtitle-1">
              {{desc}}
            </p>
>>>>>>> yang
            <p class="title">ITEMS</p>

            <v-text-field
                outlined
                style="width:100px"
                v-bind:value="this.buyNum"
                dense
                append-outer-icon="+"
                prepend-icon="–"
                @click:append-outer="addCartNum(index, item.id)"
                @click:prepend="reduceCartNum(index, item.id)"
            ></v-text-field>
            <v-btn class="primary white--text" outlined tile dense><v-icon>mdi-cart</v-icon> ADD TO CART</v-btn>

          </div>

        </div>
      </div>
      <div class="row">
        <div class="col-sm-12 col-xs-12 col-md-12">
          <v-tabs>
            <v-tab >Description</v-tab>
<<<<<<< HEAD
            <v-tab >Materials</v-tab>
=======
>>>>>>> yang
            <v-tab-item>
              <p class="pt-10 subtitle-1">
                {{desc}}
              </p>
            </v-tab-item>
<<<<<<< HEAD
            <v-tab-item>
              <p class="pt-10 subtitle-1 font-weight-thin">
                Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et
                dolore magna aliqua. Ultricies mi eget mauris pharetra et. Vel pretium lectus quam id leo in vitae turpis
                massa. Orci dapibus ultrices in iaculis nunc. At auctor urna nunc id cursus metus. Integer feugiat
                scelerisque varius morbi enim nunc. Aliquam sem et tortor consequat id porta nibh venenatis cras.
                Pellentesque pulvinar pellentesque habitant morbi tristique senectus et netus. Malesuada nunc vel risus
                commodo viverra maecenas. Neque volutpat ac tincidunt vitae semper quis.
              </p>
            </v-tab-item>
=======
>>>>>>> yang
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
<<<<<<< HEAD
            testName: '',
            rating:4.5,
            image: [
              {"src":"1.jpg"},
              {"src":"2.jpg"},
              {"src":"3.jpg"},
              {"src":"4.jpg"}
            ],
            buyNum: 1,
=======
            name:'',
            image:'',
            desc:'',
            price:0,
>>>>>>> yang
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
<<<<<<< HEAD
                    text: 'Honeywell 空氣清淨機',
                    disabled: true,
                    href: '/',
=======
                    text: '',
                    disabled: true,
>>>>>>> yang
                },
            ],
            products:[]
        }),
<<<<<<< HEAD
        methods:{

        },
        mounted: function(){
          console.log(this.$route.query.id)
=======
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
>>>>>>> yang
        },
    }
</script>
