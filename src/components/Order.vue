<template>
  <div>
    <v-container>
      <p class="display-3 font-weight-light	text-center pa-4">Order</p>
      <v-row>
        <v-col :cols="12" md="9" sm="12" >
          <v-simple-table>
            <template v-slot:default>
              <thead>
              <tr>
                <th class="text-center">ITEM</th>
                <th class="text-center">PRICE</th>
                <th class="text-center">QUANTITY</th>
                <th class="text-center">TOTAL</th>
                <th class="text-center"></th>
              </tr>
              </thead>
              <tbody>
              <tr v-for="(item,index) in goods_list" :key="index">
                <td>
                  <v-list-item
                  key="1"
                  @click=""
                >
                  <v-list-item-avatar>
                    <v-img :src="require('../assets/img/shop/1.jpg')"></v-img>
                  </v-list-item-avatar>

                  <v-list-item-content>
                    <v-list-item-title >{{item.name}}</v-list-item-title>
                    <v-list-item-subtitle>Lorem Ipsum</v-list-item-subtitle>
                  </v-list-item-content>
                </v-list-item></td>
                <td>${{item.price}}</td>
                <td>{{item.quantity}}</td>
                <td>${{item.price * item.quantity}}</td>
                <td><a @click="deleteGoods(index, item.merchandise_id)">X</a></td>
              </tr>
              <tr>
                <td>
                  <v-list-item
                  key="1"
                  @click=""
                >
                  <v-list-item-avatar>
                  </v-list-item-avatar>
                  <v-list-item-content>
                  </v-list-item-content>
                </v-list-item></td>
                <td></td>
                <td></td>
                <td>${{totalPrice}}</td>
              </tr>
              </tbody>
            </template>
          </v-simple-table>
        </v-col>
        <v-col :cols="12" md="9" sm="12" >
            <v-select class="pa-0" v-model="select" :items="options" style="margin-bottom: -20px;" outlined dense></v-select>
            <span>請選擇取貨方式: </span><br>
            <input type="radio" id="toHome" name="shipmentType" value="宅配到府" v-model="shipmentType">
            <label for="toHome">宅配到府</label>
            <input type="radio" id="to7-11" name="shipmentType" value="7-11超商取貨" v-model="shipmentType">
            <label for="to7-11">7-11超商取貨</label>
            <input type="radio" id="toFamilyMart" name="shipmentType" value="全家超商取貨" v-model="shipmentType">
            <label for="toFamilyMart">全家超商取貨</label>
        </v-col>
        <v-col :cols="12" md="9" sm="12" >
            <span>請選擇付款方式: </span><br>
            <input type="radio" id="criditCard" name="paymentType" value="信用卡付款" v-model="paymentType">
            <label for="criditCard">信用卡付款</label>
            <input type="radio" id="cash" name="paymentType" value="貨到付款" v-model="paymentType">
            <label for="cash">貨到付款</label>
            <input type="radio" id="ATM" name="paymentType" value="ATM轉帳" v-model="paymentType">
            <label for="ATM">ATM轉帳</label>
        </v-col>
        <div class="text-center">
          <v-btn href = "/" class="primary white--text mt-5" outlined @click="placeOrder()">Place Order</v-btn>
        </div>
      </v-row>
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
        data() {
        return {
          shipmentType:"宅配到府",
          paymentType:"信用卡付款",
          goods_list:[],
          totalPrice:0,
          coupon_list:[],
          select:'None',
          options: [
              'None',
          ],
        };
        
      },
        watch:{
          select: function(newVal, oldVal){
              console.log(newVal)
              console.log(oldVal)
              console.log('watch select')
              this.setTotalPrice()
          },
        },
       created(){
         // show cart item
          console.log('created')
          var config={
            method: 'get',
            url: '/api/get-cart',
            headers: {'Authorization': localStorage.getItem("accessToken")}
          };
          axios(config).then((response)=>{
            console.log('getShopCartssssss')
            var totalPrice = 0
            this.goods_list = response.data
            console.log(this.goods_list)
            this.goods_list.forEach(element => {
                totalPrice += element.price * element.quantity
            })
            this.totalPrice = totalPrice
            console.log(this.totalPrice)
          });

          // show coupon
          console.log('getCoupon')
          var config1={
            method: 'get',
            url: '/api/get-coupon',
            headers: {'Authorization': localStorage.getItem("accessToken")}
          };
          axios(config1).then((response)=>{
            this.coupon_list = response.data
            
            this.coupon_list.forEach(element => {
                this.options.push(element.code)
            })
          });
        },
        methods:{
          setTotalPrice(){
            console.log('setTotalPrice')
            var goods_list = this.goods_list
            var totalPrice = 0
            for (var i = 0; i < goods_list.length; i++)
              totalPrice += goods_list[i].quantity * goods_list[i].price
            this.totalPrice = totalPrice

            // Coupon     Testing!!!!!!!!!!!!!!!!!!!!!!!!!!!!
            if (this.select != 'None')
            {
              var selectedCoupon = {};
              console.log(this.coupon_list.length)
              for (var i = 0; i < this.coupon_list.length; i++) {
                console.log(this.select)
                console.log(this.coupon_list[i].code)
                if (this.select == this.coupon_list[i].code)
                {
                  console.log('ININ')
                  selectedCoupon = this.coupon_list[i]
                }
              } 

              console.log(selectedCoupon)
              if (selectedCoupon.type == "折扣")
                this.totalPrice *= (selectedCoupon.content / 100)
              else
                this.totalPrice -= selectedCoupon.content
            }
          },
          placeOrder(){
            var config={
              method: 'post',
              url: '/api/place-order',
              data: {
                coupon_code: false,
                products:this.goods_list,
                shipping_type: this.shipmentType,
                payment_type: this.paymentType
              },
              headers: {'Authorization': localStorage.getItem("accessToken")}
            };
            if (this.select != "None")
            {
              var lst = this.select.split('-')
              console.log(lst)
              config.data.coupon_code = lst[0]
            }

            axios(config).then((response)=>{})
          },
          deleteGoods(index, id){
            var config={
              method: 'delete',
              url: `/api/delete-merchandise/${id}`,
              headers: {'Authorization': localStorage.getItem("accessToken")},
              
            };
        
            if(confirm('remove this item from your order?'))
            {
              axios(config).then((response)=>{
              this.goods_list.splice(index, 1)
              this.setTotalPrice()
            })
            }
          }
        },
    }
</script>

