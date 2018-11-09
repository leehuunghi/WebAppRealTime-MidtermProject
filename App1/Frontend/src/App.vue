<template>
  <div id="app">
   <router-view v-if="authenticated" :to="{ name: 'FormLogin' }"/>
   <router-view :to="{ name: 'FormInformation' }" />
  </div>
</template>

<script>
export default {
  data:{
    name: 'App',
    authenticated: true
  }

}
</script>
