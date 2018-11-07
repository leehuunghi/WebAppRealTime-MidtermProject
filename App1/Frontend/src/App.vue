<template>
  <div id="app">
   <router-view :to="{ name: 'FormLogin' }"/>
   <!-- <router-view :to="{ name: 'FormInformation' }" v-if="logged" /> -->
  </div>
</template>

<script>
export default {
  data:{
    name: 'App',
    logged: false
  }

}
</script>
