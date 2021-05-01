import 'package:weather_app/domain/weather_api_response.dart';

abstract class IWeatherRepository {
  WeatherApiResponse getWeatherByCoordinates(Coordinates coordinates);
  WeatherApiResponse getWeatherByCity({
    required final String name,
    final String? stateCode,
    final String? countryCode,
  });
}
