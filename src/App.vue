<template>
  <div id="app">
    <div class="row no-gutters">
      <!-- 選擇地區 -->
      <div class="toolbox col-sm-4 p-2 bg-white">
        <div class="form-group d-flex">
          <label for="cityName" class="col-form-label mr-2 text-right">縣市</label>
          <div class="flex-fill">
            <select id="cityName" class="form-control"></select>
          </div>
        </div>
        <div class="form-group d-flex">
          <label for="area" class="col-form-label mr-2 text-right">地區</label>
          <div class="flex-fill">
            <select id="area" class="form-control"></select>
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
</script>

<style lang="scss">
  @import 'bootstrap/scss/bootstrap';

  #map {
    position: relative;
    height: 100vh;
  }
</style>
