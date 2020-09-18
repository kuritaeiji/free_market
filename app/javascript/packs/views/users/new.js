import Vue from 'vue'
import axios from 'axios'

Vue.config.devtools = true

document.addEventListener('DOMContentLoaded', () => {
  const postalCode = document.querySelector("[v-model='user.postalCode']").value
  const address = document.querySelector("[v-model='user.address']").value

  new Vue({
    el: '.users-form',
    data: {
      user: {
        postalCode: postalCode,
        address: address
      }
    },
    methods: {
      async searchAddress() {
        try {
          let response = await axios.get('https://apis.postcode-jp.com/api/v3/postcodes',
          { params: { postcode: this.user.postalCode, apikey: 'Asxr4mQIgrwHzOtTcNiuhq0N585c9XN220x8nCj' } })
          this.user = Object.assign({}, this.user, { prefectureId: response.data.data[0].prefCode, address: response.data.data[0].allAddress})
          document.getElementById('user_prefecture_id').value = response.data.data[0].prefCode
        } catch (error) {
          console.log(error)
        }
      }
    }
  })
})