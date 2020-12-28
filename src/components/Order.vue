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
              <tr>
                <td>
                  <v-list-item
                  key="1"
                  @click=""
                >
                  <v-list-item-avatar>
                    <v-img :src="require('../assets/img/shop/1.jpg')"></v-img>
                  </v-list-item-avatar>

                  <v-list-item-content>
                    <v-list-item-title >Item 1</v-list-item-title>
                    <v-list-item-subtitle>Lorem Ipsum</v-list-item-subtitle>
                  </v-list-item-content>
                </v-list-item></td>
                <td>$40.00</td>
                <td>2</td>
                <td>$80.00</td>
                <td><a>X</a></td>
              </tr>
              <tr>
                <td>
                  <v-list-item
                  key="1"
                  @click=""
                >
                  <v-list-item-avatar>
                    <v-img :src="require('../assets/img/shop/2.jpg')"></v-img>
                  </v-list-item-avatar>

                  <v-list-item-content>
                    <v-list-item-title >Item 2</v-list-item-title>
                    <v-list-item-subtitle>Lorem Ipsum</v-list-item-subtitle>
                  </v-list-item-content>
                </v-list-item></td>
                <td>$40.00</td>
                <td>2</td>
                <td>$80.00</td>
                <td><a>X</a></td>
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
                <td>$160.00</td>
              </tr>
              </tbody>
            </template>
          </v-simple-table>
        </v-col>
        <v-col :cols="12" md="9" sm="12" >
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
    export default {
        data() {
        return {
          shipmentType:"宅配到府",
          paymentType:"信用卡付款"
        };
      }
    }
</script>

