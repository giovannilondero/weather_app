// Dart imports:
import 'dart:math' as math;

// Package imports:
import 'package:freezed_annotation/freezed_annotation.dart';

// Project imports:
import 'package:weather_app/domain/day_weather.dart';

part 'full_day_weather_details.freezed.dart';

@freezed
class FullDayWeatherDetails with _$FullDayWeatherDetails {
  const factory FullDayWeatherDetails({
    required final DateTime date,
    required final List<DayWeatherData> dayDetails,
  }) = _FullDayWeatherDetails;

  const FullDayWeatherDetails._();

  /// Get the highest temperature of the day
  double get tempMax => dayDetails.fold<double>(
        double.negativeInfinity,
        (max, day) => math.max(max, day.main.tempMax),
      );

  /// Get the lowest temperature of the day
  double get tempMin => dayDetails.fold<double>(
        double.infinity,
        (min, day) => math.min(min, day.main.tempMin),
      );

  /// Get the average wind speed of the day
  double get windSpeed => _averageOf((day) => day.wind?.speed ?? 0);

  /// Get the average wind direction (in degrees) of the day
  double get windDeg => _averageOf((day) => day.wind?.deg ?? 0);

  /// Get the average probability of precipitation of the day
  int get popPercentage => (_averageOf((day) => day.pop) * 100).toInt();

  /// Get the average humidity of the day
  int get humidityPercentage =>
      _averageOf((day) => day.main.humidity.toDouble()).toInt();

  /// Get the average pressure of the day
  double get pressure => _averageOf((day) => day.main.pressure.toDouble());

  /// Get the icon which appears the most during the day.
  /// If multiple icons appear the same number of times, the first will be shown.
  String? get icon => dayDetails
      .fold<Map<String, int>>({}, (map, day) {
        if (day.weather.isEmpty) {
          return map;
        }

        final _icon = day.weather.elementAt(0).icon;
        map.update(
          _icon,
          (value) => value + 1,
          ifAbsent: () => 1,
        );

        return map;
      })
      .entries
      .fold<MapEntry<String, int>>(
        const MapEntry('', 0),
        (previousValue, element) =>
            element.value > previousValue.value ? element : previousValue,
      )
      .key;

  /// Get the average of a property from FullDayWeatherDetails.dayDetails.
  double _averageOf(double Function(DayWeatherData) callback) {
    final average = dayDetails.fold<double>(
          0,
          (total, day) => total + callback(day),
        ) /
        dayDetails.length;

    return double.parse(average.toStringAsFixed(2));
  }
}
