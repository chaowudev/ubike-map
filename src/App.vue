<template>
  <div id="app">
    <div class="row no-gutters">
      <!-- 選擇地區 -->
      <div class="toolbox col-sm-4 p-2 bg-white">
        <div class="form-group d-flex">
          <label for="cityName" class="col-form-label mr-2 text-right">縣市</label>
          <div class="flex-fill">
            <select id="cityName" class="form-control" v-model="select.city">
              <option value="">請選擇縣市</option>
              <option :value="city.name" v-for="city in cityName" :key="city.name">
                {{ city.name }}
              </option>
            </select>
          </div>
        </div>
        <div class="form-group d-flex">
          <label for="area" class="col-form-label mr-2 text-right">地區</label>
          <div class="flex-fill">
            <select id="area" class="form-control" v-model="select.dist">
              <option value="">請選擇地區</option>
              <option v-bind:key="dist.name" v-bind:value="dist.name"
                v-for="dist in cityName.find((city) => city.name === select.city).districts">
                {{ dist.name }}
              </option>
            </select>
          </div>
        </div>
      </div>

      <!-- 顯示 ubike 站點 -->
      <div class="col-sm-12">
        <div id="map"></div>
      </div>
    </div>
  </div>
</template>

<script>
import cityName from './assets/cityName.json';

export default {
  name: 'App',
  data: () => ({
    cityName,
    select: {
      city: '臺北市',
      dist: '中正區',
    },
  }),
};
</script>

<style lang="scss">
  @import 'bootstrap/scss/bootstrap';

  #map {
    position: relative;
    height: 100vh;
  }
</style>
