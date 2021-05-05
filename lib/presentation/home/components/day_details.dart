import 'package:flutter/material.dart';

// Package imports:
import 'package:intl/intl.dart';

// Project imports:
import 'package:weather_app/domain/full_day_weather_details.dart';
import 'package:weather_app/domain/weather_api_response.dart';

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
    final textTheme = Theme.of(context).textTheme;

    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          const Spacer(),
          const SizedBox(height: 32),
          // Date
          Text(
            DateFormat('EEEE, d MMMM').format(day.date).toUpperCase(),
            style: textTheme.headline5,
          ),
          const SizedBox(height: 32),
          // Temperature and description
          Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                '${day.dayDetails.elementAt(0).main.temp.round()}°',
                style: textTheme.headline3?.apply(fontSizeFactor: 3.5).merge(
                      const TextStyle(
                        letterSpacing: -10,
                        height: 1,
                      ),
                    ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // if (day.icon != null) WeatherIcon(code: day.icon!),
                  Text(
                    day.dayDetails
                        .elementAt(0)
                        .weather
                        .elementAt(0)
                        .description
                        .toUpperCase(),
                    style: textTheme.headline6,
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 32),
          // Additional daily info
          IntrinsicHeight(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _BottomInfo(
                  title: const Text('HUMIDITY'),
                  child: Text('${day.humidityPercentage}%'),
                ),
                const _VerticalDivider(),
                _BottomInfo(
                  title: const Text('WIND'),
                  child: Column(
                    children: [
                      Text(
                          '${getCardinalDirectionFromDegrees(day.windDeg)} - ${day.windSpeed} m/s'),
                      // Transform.rotate(
                      //   angle: pi / 180 * day.windDeg,
                      //   child: const Icon(Icons.arrow_upward),
                      // ),
                    ],
                  ),
                ),
                const _VerticalDivider(),
                _BottomInfo(
                  title: const Text('TEMPERATURE'),
                  child:
                      Text('${day.tempMax.toInt()}° / ${day.tempMin.toInt()}°'),
                ),
              ],
            ),
          ),
          const Spacer(flex: 3),
        ],
      ),
    );
  }
}

class _VerticalDivider extends StatelessWidget {
  const _VerticalDivider({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return VerticalDivider(
      width: 0,
      color: Colors.blueGrey.shade100,
      thickness: 2,
      indent: 5,
    );
  }
}

class _BottomInfo extends StatelessWidget {
  final Widget title;
  final Widget child;

  const _BottomInfo({
    Key? key,
    required this.title,
    required this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        title,
        const SizedBox(height: 8),
        child,
      ],
    );
  }
}

String getCardinalDirectionFromDegrees(double deg) {
  if (11.25 < deg && deg <= 33.75) return 'NNE';
  if (33.75 < deg && deg <= 56.25) return 'NE';
  if (56.25 < deg && deg <= 78.75) return 'ENE';
  if (78.75 < deg && deg <= 101.25) return 'E';
  if (101.25 < deg && deg <= 123.75) return 'ESE';
  if (123.75 < deg && deg <= 146.25) return 'SE';
  if (146.25 < deg && deg <= 168.75) return 'SSE';
  if (168.75 < deg && deg <= 191.25) return 'S';
  if (191.25 < deg && deg <= 213.75) return 'SSW';
  if (213.75 < deg && deg <= 236.25) return 'SW';
  if (236.25 < deg && deg <= 258.75) return 'WSW';
  if (258.75 < deg && deg <= 281.25) return 'W';
  if (281.25 < deg && deg <= 303.75) return 'WNW';
  if (303.75 < deg && deg <= 326.25) return 'NW';
  if (326.25 < deg && deg <= 348.75) return 'NNW';
  // if (deg > 348.75 || deg <= 11.25)
  return 'N';
}
