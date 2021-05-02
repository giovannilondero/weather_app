import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:weather_app/domain/day_weather.dart';

part 'full_day_weather_details.freezed.dart';

@freezed
class FullDayWeatherDetails with _$FullDayWeatherDetails {
  const factory FullDayWeatherDetails({
    required final DateTime date,
    required final List<DayWeatherData> dayDetails,
  }) = _FullDayWeatherDetails;

  const FullDayWeatherDetails._();

  // temp max e temp min giornata (main>tempMin, main>tempMax)
  // vento, precipitazioni, umidità, pressione (wind>speed, wind>deg, pop, main>humidity, main>pressure)
  // orari giornata, ognuno con suo tempo e temp
  // TODO: prendere gli effettivi valori qui
  double get tempMax => 2;
  double get tempMin => 1;

  double get windSpeed => 2;
  double get windDeg => 2;

  double get pop => 2;

  double get humidity => 2;
  double get pressure => 2;

  String? get icon => '10d';
}
