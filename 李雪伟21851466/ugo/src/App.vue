<template>
  <div id="app">
    <indexPage></indexPage>
  </div>
</template>

<script>
import indexPage from './pages/Index.vue'
export default {
  name: 'app',
  components:{
    indexPage,
  },
}
</script>
<style>
#id{
  position: absolute;
  width: 100%;
  height: 100%;
  overflow-x:visible;
}
</style>
