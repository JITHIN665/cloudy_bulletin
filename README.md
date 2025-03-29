# 🌤️ Cloudy Bulletin

**Cloudy Bulletin** is a Flutter app that combines real-time weather updates with dynamic news curation based on current climate and user preferences.

---

## 🚀 Features

### 🏠 Home Screen
- **Current Weather** based on location:
  - Temperature (°C/°F switch)
  - Weather condition description
  - Humidity, wind, 5-day forecast with animated Lottie icons
- **News Feed**:
  - Automatically filters news based on current weather (e.g. "tragedy" on cold/fog, "danger" on storm)
  - Headline image, title, short description, published date
  - Tap to open full article in browser
  - **Pagination**: Load more on scroll
- **Shimmer loading effect** for weather and news while fetching

---

### ⚙️ Settings Screen
- **Temperature Unit Toggle** (°C ↔ °F) with instant refresh
- **News Category Selector** (Max 5 selections)
  - Filters news list based on selected categories
  - Categories include:  
    `business`, `crime`, `education`, `entertainment`, `environment`, `food`, `health`, `lifestyle`, `politics`, `science`, `sports`, `technology`, `top`, `tourism`, `world`, etc.

---

### 🔍 Smart News Filtering Logic

#### Climate-Based Filtering
- App auto-generates news keywords using the weather description:
  - `cold, fog, snow` → `['depressing', 'tragedy']`
  - `hot, storm, thunder` → `['fear', 'danger']`
  - `clear sky, mild, sunny` → `['positivity', 'happiness']`

#### Category-Based Filtering
- If the user selects news categories in settings, they take priority and override climate-based keywords.

---

## 📡 Connectivity & Location Checker

- The app uses a **global `ConnectivityGuard`** that wraps all screens:
  - Checks both **internet (Wi-Fi or mobile)** and **location services**
  - If either is disabled, it shows a popup to enable them
  - Once both are available, it automatically refreshes the weather and news

## 🧪 Manual Testing Procedure

| Test Scenario                       | Expected Behavior                                              |
|------------------------------------|----------------------------------------------------------------|
| Toggle temperature unit            | Weather updates to new unit                         |
| Select news categories             | Only related news is shown in Home                            |
| Deselect all categories            | News is filtered based on current weather                     |
| Scroll down news list              | Loads more headlines (pagination works)                       |
| 5-day forecast                     | Only 5 unique future days shown                               |
| Location permission denied         | Weather does not show and handles gracefully                  |


## 🧱 Tech Stack

- Flutter (## 🧱 Tech Stack

- Flutter (3.29.2)
- Dart (3.7.2)
- GetX for state management & routing
- Lottie for weather animations
- Shimmer for loading effects
- NewsAPI for fetching news
- OpenWeatherMap for weather data
- Geolocator & Geocoding for location

---)

---

## 🧪 Testing

### ✅ Automated Unit & Widget Tests

```bash
flutter test

## ⚙️ CI/CD – GitHub Actions

This project uses **GitHub Actions** for automated testing and analysis.

Cloudy Bulletin is also compatible with Appcircle.GitHub connected  for automated testing and analysis with Default PR Workflow.
