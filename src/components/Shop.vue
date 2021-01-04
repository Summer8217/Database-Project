<template>
  <div>
    <v-container>
      <div class="row">
        <div
         class="col-md-3 col-sm-3 col-xs-12"
        >
          <v-card outlined>
            <v-card-title class="pb-0">Type</v-card-title>
            <v-container class="pt-0" fluid>
              <v-checkbox v-model="type" value="Air Purifier" label="Air Purifier" hide-details dense></v-checkbox>
              <v-checkbox v-model="type" value="Vacuum" label="Vacuum" hide-details dense></v-checkbox>
              <v-checkbox v-model="type" value="Fan" label="Fan" hide-details dense></v-checkbox>
              <v-checkbox v-model="type" value="Light" label="Light" hide-details dense></v-checkbox>
            </v-container>
            <v-divider></v-divider>
            <v-card-title>Price</v-card-title>
            <v-range-slider
              v-model="range"
              :max="max"
              :min="min"
              :height="10"
              class="align-center"
              dense
            ></v-range-slider>
            <v-row class="pa-2" dense>
              <v-col cols="12" sm="5">
                <v-text-field
                  :value="range[0]"
                  label="Min"
                  outlined
                  dense
                  @change="$set(range, 0, $event)"
                ></v-text-field>
              </v-col>
              <v-col cols="12" sm="2">
                <p class="pt-2 text-center">TO</p>
              </v-col>
              <v-col cols="12" sm="5">
                <v-text-field
                  :value="range[1]"
                  label="Max"
                  outlined
                  dense
                  @change="$set(range, 1, $event)"
                ></v-text-field>
              </v-col>
            </v-row>
            
          </v-card>
        </div>
        <div
          class="col-md-9 col-sm-9 col-xs-12"
        >

          <v-breadcrumbs class="pb-0" :items="breadcrums"></v-breadcrumbs>

          <v-row dense>
            <v-col cols="12" sm="8" class="pl-6 pt-6">
              <small>Showing {{show[0]+(page-1)*12}}-{{Math.min(show[1]*page, amount)}} of {{amount}} products</small>
            </v-col>
            <v-col cols="12" sm="4">
              <v-select class="pa-0" v-model="select" :items="options" style="margin-bottom: -20px;" outlined dense></v-select>
            </v-col>
          </v-row>

          <v-divider></v-divider>

          <div class="row text-center">
            <div class="col-md-3 col-sm-6 col-xs-12" :key="pro.id" v-for="pro in filterProduct">
              <v-hover v-slot:default="{ hover }">
                <v-card
                  class="mx-auto"
                  color="grey lighten-4"
                  max-width="600"
                >
                  <v-img
                    class="white--text align-end"
                    :aspect-ratio="16/9"
                    height="200px"
                    :src="'data:image/png;base64, '+pro.image"
                  >
                    <v-card-title>{{pro.type}} </v-card-title>
                    <v-expand-transition>
                      <div
                        v-if="hover"
                        class="d-flex transition-fast-in-fast-out white darken-2 v-card--reveal display-3 white--text"
                        style="height: 100%;"
                      >
                        <v-btn v-if="hover" :href="'product/'+pro.id" class="" outlined>VIEW</v-btn>
                      </div>

                    </v-expand-transition>
                  </v-img>
                  <v-card-text class="text--primary">
                    <!--<div><a href="/product" style="text-decoration: none">{{pro.name}}</a></div>-->
                    <div>{{pro.name}}</div>
                    <div>${{pro.price}}</div>
                  </v-card-text>
                </v-card>
              </v-hover>
            </div>
          </div>
          <div class="text-center mt-12">
            <v-pagination
              v-model="page"
              :length="length"
            ></v-pagination>
          </div>
        </div>
      </div>
    </v-container>
  </div>
</template>
<style>
  .v-card--reveal {
    align-items: center;
    bottom: 0;
    justify-content: center;
    opacity: .8;
    position: absolute;
    width: 100%;
  }
</style>

<script>
import axios from 'axios'
    export default {
        data: () => ({
            amount: 100,
            show: [1, 12],
            page:1,
            range: [0, 100000],
            length: 10,
            min:0,
            max:100000,
            type: ['Air Purifier', 'Vacuum', 'Fan', 'Light'],
            select:'Popularity',
            options: [
                'Default',
                'Popularity',
                'Relevance',
                'Price: Low to High',
                'Price: High to Low',
            ],
            breadcrums: [
                {
                    text: 'Home',
                    disabled: false,
                    href: '/',
                },
                {
                    text: 'Shop',
                    disabled: true,
                    href: '/shop',
                }
            ],
            products:[]
        }),
        created: function(){
          this.length = 1
        },
        mounted: function(){
          axios.get("/api/get-all")
          .then(response => {
            this.products = response.data.products;
            this.length = parseInt(response.data.amount / 12)
            if (response.data.amount % 12 != 0) this.length++
            this.amount = response.data.products.length;
          })
          .catch(error => {
            console.log(error)
          })
        },

        watch: {
          range: function(){
            this.page = 1
          },
        },
        
        computed: {
          filterProduct: function(){
            let low = this.range[0]
            let high = this.range[1]
            let type = this.type


            var newProducts = this.products.filter(function(product){
              return product.price >= low && product.price <= high && (product.name.indexOf(type[0]) > -1 || product.name.indexOf(type[1]) > -1 || product.name.indexOf(type[2]) > -1 || product.name.indexOf(type[3]) > -1)
            })

            this.amount = newProducts.length
            this.length = parseInt(this.amount  / 12)
            if (this.amount % 12 != 0) this.length++

            console.log(this.select)
            switch (this.select){
              case "Price: Low to High":
                newProducts.sort(function(a, b) {
                  return a.price > b.price ? 1 : -1;
                })
                break

              case "Price: High to Low":
                newProducts.sort(function(a, b) {
                  return a.price < b.price ? 1 : -1 
                })
                break

              default:
                console.log("no")
                break
            }
            return newProducts.slice((this.page-1)*12, ((this.page-1)*12)+12)
          }
        }
        
        
        
    }
</script>
