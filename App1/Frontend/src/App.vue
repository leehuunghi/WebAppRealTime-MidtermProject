<template>
  <div id="app">
   <router-view :to="{ name: 'FormLogin' }"/>
   <router-view v-if="authenticated" :to="{ name: 'FormInformation' }" />
  </div>
</template>

<script>
export default {
  data:{
    name: 'App',
    authenticated: false
  }

}
</script>
