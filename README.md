- [Weather app](#weather-app)
  - [Inspiration](#inspiration)
  - [App architecture](#app-architecture)
  - [Development](#development)
  - [Commands](#commands)
    - [Build runner](#build-runner)

# Weather app

This is a functioning example of an app to check the weather for the next 5 days.

## Inspiration

UI inspiration: https://pin.it/26LiJKz.

Initially, the app was being developed based on the following designs (kept for reference and, maybe, future use):

- https://dribbble.com/shots/14931699-Weather-App
- https://www.behance.net/gallery/74277987/Weather-App-Case-Study-DailyUI7
- https://dribbble.com/shots/14798598-Weather-app

## App architecture

Refer to [ARCHITECTURE.md](./ARCHITECTURE.md).

## Development

First thing, you'll need to get an OpenWeatherAPI key (https://openweathermap.org/) and add it to the [.env](./.env) file (replace the "example" text).

Before running the project, get the project's dependencies with `flutter pub get`, then [run the build_runner](#build-runner).

To run the project, either run it from an IDE or use the CLI (`flutter run`).

NOTE: this app has been developed and tested on iPhone 12 Pro Max Simulator (iOS 14.5) and iPhone X (iOS 14.4.2).

## Commands

### Build runner

```bash
flutter pub run build_runner build --delete-conflicting-outputs
```

### Sort imports

```bash
flutter pub run import_sorter:main
```

### Create launcher icons:

```bash
flutter pub run flutter_launcher_icons:main
```
