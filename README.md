- [Weather app](#weather-app)
  - [Use cases](#use-cases)
  - [Commands](#commands)

# Weather app

This is a functioning example of an app to check the weather for the next 5 days.

## Use cases

The user will be able to choose if geolocation should be used:

- if yes, the default weather will be based on user's location, but another location can still be searched;
- if not, the user must manually search a location.

Bonuses:

- users can see the details of a single day;
- users can save favourites cities.

## Commands

Build:

```bash
flutter pub run build_runner build --delete-conflicting-outputs
```

Sort imports:

```bash
flutter pub run import_sorter:main
```

Create launcher icons:

```bash
flutter pub run flutter_launcher_icons:main
```
