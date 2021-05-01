import 'package:flutter/material.dart';
import 'package:weather_app/domain/weather_api_response.dart';
import 'package:weather_app/infrastructure/weather_repository.dart';
import 'package:weather_app/presentation/home/components/weather_days_list.dart';

class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Weather'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            FutureBuilder(
              future: WeatherRepository().getWeatherByCity(name: 'London'),
              builder: (context, AsyncSnapshot<WeatherApiResponse?> snapshot) {
                if (snapshot.hasData) {
                  return WeatherDaysList(days: snapshot.data!.list);
                }

                return const Text('Loading...');
              },
            ),
            // Let the colum scroll a bit longer when there's a system UI element at the bottom (e.g. on iPhoneX and later)
            SizedBox(height: MediaQuery.of(context).padding.bottom),
          ],
        ),
      ),
    );
  }
}
