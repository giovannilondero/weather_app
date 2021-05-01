import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:weather_app/domain/i_weather_repository.dart';
import 'package:weather_app/domain/weather_api_response.dart';

class WeatherRepository implements IWeatherRepository {
  static const _apiUrl = 'https://api.openweathermap.org/data/2.5/forecast';
  static final _apiKey = env["API_KEY"] ?? '';

  @override
  Future<WeatherApiResponse> getWeatherByCity({
    required String name,
    String? stateCode,
    String? countryCode,
  }) async {
    final queryValues = [
      name,
      stateCode,
      countryCode,
    ].whereType<String>().join(',');

    final response = await _getWeather(<String, dynamic>{
      'q': queryValues,
    });

    // TODO: gestire errore o response null

    return WeatherApiResponse.fromJson(response ?? <String, dynamic>{});
  }

  @override
  Future<WeatherApiResponse> getWeatherByCoordinates(
      Coordinates coordinates) async {
    final response = await _getWeather(<String, dynamic>{
      'lat': coordinates.latitude,
      'lon': coordinates.longitude,
    });

    // TODO: gestire errore o response null

    return WeatherApiResponse.fromJson(response ?? <String, dynamic>{});
  }

  Future<Map<String, dynamic>?> _getWeather(
      Map<String, dynamic> queryParameters) async {
    final response = await Dio().get<Map<String, dynamic>>(
      _apiUrl,
      queryParameters: <String, dynamic>{
        'appid': _apiKey,
        ...queryParameters,
      },
    );

    return response.data;
  }
}
