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
import L from 'leaflet';
import cityName from './assets/cityName.json';

export default {
  name: 'App',
  data: () => ({
    cityName,
    select: {
      city: '臺北市',
      dist: '中正區',
    },
    ubikes: [],
    OSMap: {},
  }),
  computed: {
    // 篩選出與選擇區域相符區域的 ubike 站點
    youbikes() {
      return this.ubikes.filter((bike) => {
        if (!this.select.dist) {
          return this.select.city;
        }
        return bike.sarea === this.select.dist;
      });
    },
  },
  watch: {
    youbikes() {
      // 當 youbikes 的值變動時，就會執行 updateMap() 方法
      this.updateMap();
    },
  },
  methods: {
    updateMap() {
      // remove markers
      this.OSMap.eachLayer((layer) => {
        if (layer instanceof L.Marker) {
          this.OSMap.removeLayer(layer);
        }
      });

      // add markers
      this.youbikes.forEach((bike) => {
        L.marker([bike.lat, bike.lng]).addTo(this.OSMap);
      });

      // move to new center
      this.cityName[0].districts.find((dist) => {
        if (this.select.dist === dist.name) {
          this.OSMap.panTo(new L.LatLng(dist.latitude, dist.longitude));
        }
        return this.select.dist === dist.name;
      });
    },
  },
  created() {
    const api = 'https://tcgbusfs.blob.core.windows.net/blobyoubike/YouBikeTP.json';
    this.$http.get(api).then((response) => {
      // response.data 是一個 Object，我們所需的 ubikes 是 Object 每一個 key 的 value（各站點資訊）
      this.ubikes = Object.keys(response.data.retVal).map((key) => response.data.retVal[key]);
    });
  },
  mounted() {
    this.OSMap = L.map('map', {
      center: [25.041956, 121.508791],
      zoom: 17,
    });

    L.tileLayer('https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png', {
      attribution: 'Map data &copy; <a href="https://www.openstreetmap.org/">OpenStreetMap</a> contributors, <a href="https://creativecommons.org/licenses/by-sa/2.0/">CC-BY-SA</a>, Imagery © <a href="https://www.mapbox.com/">Mapbox</a>',
      maxZoom: 20,
    }).addTo(this.OSMap);
  },
};
</script>

<style lang="scss">
  @import 'bootstrap/scss/bootstrap';

  #map {
    position: relative;
    height: 100vh;
  }
</style>
