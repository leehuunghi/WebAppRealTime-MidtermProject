<template>
  <div id="app">
   <router-view :to="{ name: 'Login' }"/>
</div>
</template>
<script>
export default {
  name: 'App'
}
</script>