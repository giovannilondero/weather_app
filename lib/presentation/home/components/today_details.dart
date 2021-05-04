// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:intl/intl.dart';

// Project imports:
import 'package:weather_app/domain/full_day_weather_details.dart';
import 'package:weather_app/domain/weather_api_response.dart';
import 'package:weather_app/presentation/_components/weather_icon.dart';

class TodayDetails extends StatelessWidget {
  final ResponseCity city;
  final FullDayWeatherDetails day;

  const TodayDetails({
    Key? key,
    required this.day,
    required this.city,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final now = DateTime.now();

    return Column(
      children: [
        Text(city.name),
        Text(DateFormat('EEE, d MMMM HH:mm').format(now)),
        Row(
          children: [
            if (day.icon != null) WeatherIcon(code: day.icon!),
            Text('${day.dayDetails.elementAt(0).main.temp.round()}°'),
            Text(day.dayDetails.elementAt(0).weather.elementAt(0).description),
          ],
        ),
        SizedBox(
          height: 100,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: day.dayDetails.length,
            itemBuilder: (context, index) {
              final element = day.dayDetails.elementAt(index);
              return Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(DateFormat('HH:mm').format(
                      DateTime.fromMillisecondsSinceEpoch(element.dt * 1000))),
                  Text('${element.main.temp.round()}°'),
                  WeatherIcon(
                    code: element.weather.elementAt(0).icon,
                    height: 50,
                  ),
                ],
              );
            },
          ),
        ),
      ],
    );
  }
}
