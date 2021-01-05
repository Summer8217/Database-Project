<template>
    <v-content>
      <v-bottom-navigation
        :value="activeBtn"
        color="primary"
        horizontal
      >
        <a href="/User" class="v-btn">
          <span>Profile</span>
        </a>
        <a href="/shop" class="v-btn">
          <span>Shop</span>
        </a>
        <v-btn href="/blog">
          <span>About</span>
        </v-btn>
      </v-bottom-navigation>
    </v-content>
</template>


<script>

</script>