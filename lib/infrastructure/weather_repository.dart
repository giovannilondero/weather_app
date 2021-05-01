import 'package:weather_app/domain/i_weather_repository.dart';
import 'package:weather_app/domain/weather_api_response.dart';

class WeatherRepository implements IWeatherRepository {
  @override
  WeatherApiResponse getWeatherByCity({
    required String name,
    String? stateCode,
    String? countryCode,
  }) {
    // TODO: implement getWeatherByCity
    throw UnimplementedError();
  }

  @override
  WeatherApiResponse getWeatherByCoordinates(Coordinates coordinates) {
    // TODO: implement getWeatherByCoordinates
    throw UnimplementedError();
  }
}
