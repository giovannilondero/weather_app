import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:weather_app/domain/day_weather.dart';
import 'package:weather_app/domain/full_day_weather_details.dart';
import 'package:weather_app/infrastructure/weather_repository.dart';
import 'package:weather_app/presentation/_components/weather_icon.dart';
import 'package:weather_app/presentation/home/components/weather_days_list.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  FullDayWeatherDetails? today;
  List<FullDayWeatherDetails>? nextDays;

  @override
  void initState() {
    super.initState();

    loadData();
  }

  Future<void> loadData() async {
    final response = await WeatherRepository().getWeatherByCity(name: 'London');

    final dayWeatherDetailsList = response.list
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
    today = dayWeatherDetailsList.first;

    // TODO: get next 5 days
    nextDays = dayWeatherDetailsList.skip(1).toList();

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
            if (today != null) Today(today!),
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

class Today extends StatelessWidget {
  final FullDayWeatherDetails day;

  const Today(
    this.day, {
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final now = DateTime.now();

    return Column(
      children: [
        const Text('London'),
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
