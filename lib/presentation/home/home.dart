import 'package:flutter/material.dart';
import 'package:weather_app/domain/day_weather.dart';
import 'package:weather_app/domain/full_day_weather_details.dart';
import 'package:weather_app/domain/weather_api_response.dart';
import 'package:weather_app/infrastructure/weather_repository.dart';
import 'package:weather_app/presentation/home/components/today_details.dart';
import 'package:weather_app/presentation/home/components/weather_days_list.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  FullDayWeatherDetails? today;
  List<FullDayWeatherDetails>? nextDays;
  ResponseCity? city;

  String search = '';

  @override
  void initState() {
    super.initState();

    // loadData();
  }

  // TODO: spostare questo loadData da un'altra parte e riportare a stateless widget
  Future<void> loadData(String searchValue) async {
    final response =
        await WeatherRepository().getWeatherByCity(name: searchValue);

    updateFromWeatherData(response.list);
    city = response.city;

    setState(() {});
  }

  void updateFromWeatherData(List<DayWeatherData> weatherDataList) {
    final dayWeatherDetailsList = weatherDataList
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

    today = dayWeatherDetailsList.first;

    nextDays = dayWeatherDetailsList.skip(1).toList();
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
            TextField(
              decoration: const InputDecoration(prefixIcon: Icon(Icons.search)),
              onSubmitted: (value) {
                loadData(value);
              },
            ),
            if (today != null)
              TodayDetails(
                day: today!,
                city: city!,
              ),
            if (nextDays == null) const Text('Loading...'),
            if (nextDays != null) WeatherDaysList(days: nextDays!),
            // Let the colum scroll a bit longer when there's a system UI element at the bottom (e.g. on iPhoneX and later)
            SizedBox(height: MediaQuery.of(context).padding.bottom),
          ],
        ),
      ),
    );
  }
}
