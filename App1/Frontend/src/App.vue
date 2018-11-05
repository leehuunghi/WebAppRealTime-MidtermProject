<template>
  <div id="app">
   <router-view :to="{ name: 'FormInformation' }"/>
  </div>
</template>

<script>
export default {
  name: 'App'
}
</script>
