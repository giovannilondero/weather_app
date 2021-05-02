import 'package:flutter/material.dart';
import 'package:weather_app/domain/day_weather.dart';
import 'package:weather_app/domain/full_day_weather_details.dart';
import 'package:weather_app/infrastructure/weather_repository.dart';
import 'package:weather_app/presentation/home/components/weather_days_list.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List<FullDayWeatherDetails>? dayWeatherDetailsList;

  @override
  void initState() {
    super.initState();

    loadData();
  }

  Future<void> loadData() async {
    final response = await WeatherRepository().getWeatherByCity(name: 'London');

    // TODO: group by day
    dayWeatherDetailsList = response.list
        .fold(
          <DateTime, List<DayWeatherData>>{},
          (Map<DateTime, List<DayWeatherData>> map, element) {
            final dateTime =
                DateTime.fromMillisecondsSinceEpoch(element.dt * 1000);
            final lastMidnight =
                DateTime(dateTime.year, dateTime.month, dateTime.day);

            map.update(
              lastMidnight,
              (value) => value..add(element),
              ifAbsent: () => [element],
            );

            return map;
          },
        )
        .entries
        .map((e) => FullDayWeatherDetails(
              date: e.key,
              dayDetails: e.value,
            ))
        .toList();

    // TODO: get today
    final today = dayWeatherDetailsList!.first;

    // TODO: get next 5 days
    final nextDays = dayWeatherDetailsList!.skip(1);

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Weather'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            if (dayWeatherDetailsList == null) const Text('Loading...'),
            if (dayWeatherDetailsList != null)
              WeatherDaysList(days: dayWeatherDetailsList!),
            // Let the colum scroll a bit longer when there's a system UI element at the bottom (e.g. on iPhoneX and later)
            SizedBox(height: MediaQuery.of(context).padding.bottom),
          ],
        ),
      ),
    );
  }
}
