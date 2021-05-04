// Project imports:
import 'package:weather_app/domain/weather_api_response.dart';

abstract class IWeatherRepository {
  Future<WeatherApiResponse> getWeatherByCoordinates(Coordinates coordinates);
  Future<WeatherApiResponse> getWeatherByCity({
    required final String name,
    final String? stateCode,
    final String? countryCode,
  });
}
