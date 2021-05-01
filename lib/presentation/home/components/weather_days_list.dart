import 'package:flutter/material.dart';
import 'package:weather_app/domain/weather_api_response.dart';
import 'package:weather_app/presentation/_components/weather_icon.dart';
import 'package:weather_app/presentation/home/components/weather_day.dart';

class WeatherDaysList extends StatelessWidget {
  final List<DayWeatherData> days;
  const WeatherDaysList({
    Key? key,
    required this.days,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: days
          .map(
            (day) => WeatherDay(
              dateTime: DateTime.fromMillisecondsSinceEpoch(day.dt * 1000),
              icon: day.weather.isNotEmpty
                  ? WeatherIcon(
                      code: day.weather.elementAt(0).icon,
                      width: 50,
                      height: 50,
                    )
                  : null,
              minTemp: day.main.tempMin,
              maxTemp: day.main.tempMax,
            ),
          )
          .toList(),
    );
  }
}
