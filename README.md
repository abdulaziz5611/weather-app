# Weather App

A Flutter weather app that reads the device's location, shows current conditions and forecasts, and keeps working when the network drops. Built on Clean Architecture with BLoC.

## Features

- **Current weather** — conditions for the device's location, resolved via GPS and reverse geocoding
- **Forecast charts** — hourly and daily trends drawn with `fl_chart`
- **Saved cities** — add cities and switch between them
- **Search** — find and add a location by name
- **Offline caching** — the last successful response is stored in Hive and served when the network is unavailable
- **Connectivity awareness** — the app detects loss of connection and falls back to cached data instead of failing
- **Onboarding** — first-run permission flow
- **Settings** — units and app preferences

## Tech Stack

| Layer | Choice |
| --- | --- |
| Framework | Flutter · Dart |
| State management | `flutter_bloc` |
| Dependency injection | `get_it` |
| HTTP client | `dio` |
| Local storage / cache | `hive` · `hive_flutter` |
| Functional error handling | `dartz` |
| Location | `geolocator` · `geocoding` · `permission_handler` |
| Connectivity | `connectivity_plus` |
| Charts | `fl_chart` |
| Formatting / typography | `intl` · `google_fonts` |

## Architecture

**Clean Architecture**, organised by feature:

```
lib/
├── core/
│   ├── constants/  di/  error/  network/
│   ├── routing/  services/  theme/
│   └── types/  usecases/  utils/  widgets/
└── features/
    ├── weather/     # current conditions and forecast
    ├── cities/      # saved locations
    ├── search/      # location lookup
    ├── onboarding/  # first-run flow
    └── settings/
```

Every feature has `domain`, `data` and `presentation` layers. Remote and local data sources sit behind one repository, so the decision to serve fresh or cached data is made in one place rather than scattered through the UI.

## Getting Started

```bash
git clone https://github.com/abdulaziz5611/weather-app.git
cd weather-app
flutter pub get
flutter run
```

Requires the Flutter SDK (3.x) and a device or emulator with location services. Add your weather API key to the constants file in `lib/core/constants/` before running.

## Roadmap

- Weather alerts and severe-condition notifications
- Home screen widget
- Unit tests for the repository and BLoC layers
