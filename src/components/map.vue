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
    const response = await fetch(`http://localhost:5000/weather?lat=${lat}&lng=${lng}`);
    if (!response.ok) {
      throw new Error('Failed to fetch weather data');
    }
    const data = await response.json();
    return {
      temperature: data.temperature,
      windSpeed: data.windSpeed,
      windDirection: WindDirection[data.windDirection]
    };
  }

  const WindDirection = {
    0: 'North',
    1: 'NorthEast',
    2: 'East',
    3: 'SouthEast',
    4: 'South',
    5: 'SouthWest',
    6: 'West',
    7: 'NorthWest'
  };
  </script>
  
  <style>
  .map-container {
    height: 100vh;
    width: 100%;
  }
  </style>