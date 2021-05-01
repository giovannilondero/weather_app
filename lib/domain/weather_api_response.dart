import 'package:freezed_annotation/freezed_annotation.dart';

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
class DayWeatherData with _$DayWeatherData {
  const factory DayWeatherData({
    required final int dt,
    required final MainData main,
    required final List<WeatherData> weather,
    final CloudsData? clouds,
    final WindData? wind,
    required final int visibility,
    required final double pop,
    final RainData? rain,
    required final SysData sys,
    @JsonKey(name: 'dt_txt') required final String dtTxt,
  }) = _DayWeatherData;

  factory DayWeatherData.fromJson(Map<String, dynamic> json) =>
      _$DayWeatherDataFromJson(json);
}

@freezed
class MainData with _$MainData {
  const factory MainData({
    required final double temp,
    @JsonKey(name: 'feels_like') required final double feelsLike,
    @JsonKey(name: 'temp_min') required final double tempMin,
    @JsonKey(name: 'temp_max') required final double tempMax,
    required final int pressure,
    @JsonKey(name: 'sea_level') required final int seaLevel,
    @JsonKey(name: 'grnd_level') required final int grndLevel,
    required final int humidity,
    @JsonKey(name: 'temp_kf') required final double tempKf,
  }) = _MainData;

  factory MainData.fromJson(Map<String, dynamic> json) =>
      _$MainDataFromJson(json);
}

@freezed
class WeatherData with _$WeatherData {
  const factory WeatherData({
    required final int id,
    required final String main,
    required final String description,
    required final String icon,
  }) = _WeatherData;

  factory WeatherData.fromJson(Map<String, dynamic> json) =>
      _$WeatherDataFromJson(json);
}

@freezed
class CloudsData with _$CloudsData {
  const factory CloudsData({
    required final int all,
  }) = _CloudsData;

  factory CloudsData.fromJson(Map<String, dynamic> json) =>
      _$CloudsDataFromJson(json);
}

@freezed
class WindData with _$WindData {
  const factory WindData({
    required final double speed,
    required final double deg,
    required final double gust,
  }) = _WindData;

  factory WindData.fromJson(Map<String, dynamic> json) =>
      _$WindDataFromJson(json);
}

@freezed
class RainData with _$RainData {
  const factory RainData({
    @JsonKey(name: '3h') required final double h3,
  }) = _RainData;

  factory RainData.fromJson(Map<String, dynamic> json) =>
      _$RainDataFromJson(json);
}

@freezed
class SysData with _$SysData {
  const factory SysData({
    required final String pod,
  }) = _SysData;

  factory SysData.fromJson(Map<String, dynamic> json) =>
      _$SysDataFromJson(json);
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
