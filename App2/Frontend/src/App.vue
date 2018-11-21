<template>
  <div id="app">
   <router-view :to="{ name: 'FormLogin' }"/>
  </div>
</template>

<script>
export default {
  data:{
    name: 'App',
  }
}