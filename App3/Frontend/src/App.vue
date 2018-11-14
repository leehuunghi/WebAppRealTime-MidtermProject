<template>
  <div id="app">
   <router-view :to="{ name: 'FormLogin' }"/>
   <router-view v-if="authenticated" :to="{ name: 'Manage' }" />
   <router-view v-if="mapRouter" :to="{ name: 'MapRouter' }" />
  </div>
</template>

<script>
export default {
  data:{
    name: 'App',
    authenticated: false,
    mapRouter: false,
  }
}
