<template>
    <div id="map" class="map-container"></div>
  </template>
  
  <script setup>
  import { onMounted } from 'vue';
  import L from 'leaflet';
  import 'leaflet/dist/leaflet.css';
  
  onMounted(() => {
    const map = L.map('map').setView([51.505, -0.09], 13);
  
    L.tileLayer('https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png', {
      attribution: '&copy; OpenStreetMap contributors'
    }).addTo(map);
  
    map.on('click', async (e) => {
      const { lat, lng } = e.latlng;
      const weatherData = await fetchWeatherData(lat, lng);
      alert(`Coordinates: ${lat}, ${lng}\nWeather: ${JSON.stringify(weatherData)}`);
    });
  });
  
  async function fetchWeatherData(lat, lng) {
    // Generate random weather data
    const weatherData = {
      temperature: (Math.random() * 40 - 10).toFixed(2), // Random temperature between -10 and 30 degrees Celsius
      humidity: (Math.random() * 100).toFixed(2), // Random humidity percentage
      condition: ['Sunny', 'Cloudy', 'Rainy', 'Snowy'][Math.floor(Math.random() * 4)] // Random condition
    };
    return weatherData;
  }
  </script>
  
  <style>
  .map-container {
    height: 100vh;
    width: 100%;
  }
  </style>