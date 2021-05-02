import 'package:flutter/material.dart';
import 'package:weather_app/domain/full_day_weather_details.dart';
import 'package:weather_app/presentation/_components/weather_icon.dart';
import 'package:weather_app/presentation/home/components/weather_day.dart';

class WeatherDaysList extends StatelessWidget {
  final List<FullDayWeatherDetails> days;
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
              dateTime: day.date,
              icon: day.icon != null
                  ? WeatherIcon(
                      code: day.icon!,
                      width: 50,
                      height: 50,
                    )
                  : null,
              minTemp: day.tempMin,
              maxTemp: day.tempMax,
            ),
          )
          .toList(),
    );
  }
}
