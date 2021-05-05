part of 'weather_cubit.dart';

@freezed
abstract class WeatherState with _$WeatherState {
  const factory WeatherState.initial() = _Initial;
  const factory WeatherState.loading() = _Loading;
  const factory WeatherState.error(String error) = _Error;
  const factory WeatherState.loaded({
    required List<FullDayWeatherDetails> days,
    required ResponseCity city,
  }) = _Loaded;
}
