import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:weather_app/domain/day_weather.dart';

part 'weather_api_response.freezed.dart';
part 'weather_api_response.g.dart';

// TODO: separare
// TODO: controllare, sicuramente non devono essere tutti required, alcuni saranno nullable

@freezed
class WeatherApiResponse with _$WeatherApiResponse {
  const factory WeatherApiResponse({
    required final String cod,
    required final int message,
    required final int cnt,
    required final List<DayWeatherData> list,
    required final ResponseCity city,
  }) = _WeatherApiResponse;

  factory WeatherApiResponse.fromJson(Map<String, dynamic> json) =>
      _$WeatherApiResponseFromJson(json);
}

@freezed
class ResponseCity with _$ResponseCity {
  const factory ResponseCity({
    required final int id,
    required final String name,
    required final Coordinates coord,
    required final String country,
    required final int timezone,
    required final int sunrise,
    required final int sunset,
  }) = _ResponseCity;

  factory ResponseCity.fromJson(Map<String, dynamic> json) =>
      _$ResponseCityFromJson(json);
}

@freezed
class Coordinates with _$Coordinates {
  const factory Coordinates({
    @JsonKey(name: 'lat') required final double latitude,
    @JsonKey(name: 'lon') required final double longitude,
  }) = _Coordinates;

  factory Coordinates.fromJson(Map<String, dynamic> json) =>
      _$CoordinatesFromJson(json);
}
