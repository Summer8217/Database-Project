<template>
  <div>
    <v-container>
      <div class="row">
        <div class="col-md-12 col-sm-12 col-xs-12">
          <v-simple-table>
            <template v-slot:default>
              <thead>
              <tr>
                <th>Activated</th>  
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