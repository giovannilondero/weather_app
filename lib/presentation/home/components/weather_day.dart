import 'dart:math' show pi;

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:weather_app/domain/full_day_weather_details.dart';
import 'package:weather_app/presentation/_components/weather_icon.dart';

class WeatherDay extends StatelessWidget {
  final FullDayWeatherDetails dayDetails;
  final bool expanded;

  const WeatherDay(
    this.dayDetails, {
    Key? key,
    this.expanded = true,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      decoration: BoxDecoration(
        // color: Colors.grey[300],
        // color: Colors.blueGrey[50],
        borderRadius: BorderRadius.circular(30),
      ),
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                flex: 3,
                child: Text(DateFormat('E, d MMM').format(dayDetails.date)),
              ),
              if (dayDetails.icon != null)
                Expanded(
                  child: WeatherIcon(
                    code: dayDetails.icon!,
                    width: 50,
                    height: 50,
                  ),
                ),
              Expanded(
                flex: 2,
                child: Text(
                  '${{
                    dayDetails.tempMin.round(),
                    dayDetails.tempMax.round()
                  }.join(' / ')} °C',
                  textAlign: TextAlign.right,
                ),
              ),
            ],
          ),
          if (expanded) const Divider(),
          if (expanded)
            Wrap(
              children: [
                Text('Precipitation ${dayDetails.popPercentage}%'),
                Text('Wind ${dayDetails.windSpeed} m/s'),
                Text('${dayDetails.windDeg}'),
                Transform.rotate(
                  angle: pi / 180 * dayDetails.windDeg,
                  child: const Icon(Icons.arrow_upward),
                ),
                Text('Humidity ${dayDetails.humidityPercentage}%'),
                Text('Pressure ${dayDetails.pressure} hPa'),
              ],
            ),
        ],
      ),
    );
  }
}
