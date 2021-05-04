// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:flutter_bloc/flutter_bloc.dart';

// Project imports:
import 'package:weather_app/application/weather/weather_cubit.dart';
import 'package:weather_app/presentation/home/components/today_details.dart';
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
            TextField(
              decoration: const InputDecoration(prefixIcon: Icon(Icons.search)),
              onSubmitted: (value) {
                context.read<WeatherCubit>().loadByCityName(value);
              },
            ),
            context.watch<WeatherCubit>().state.maybeWhen(
                  loaded: (today, nextDays, city) => Column(
                    children: [
                      TodayDetails(
                        day: today,
                        city: city,
                      ),
                      WeatherDaysList(days: nextDays),
                    ],
                  ),
                  loading: () => const CircularProgressIndicator(),
                  orElse: () => const SizedBox.shrink(),
                ),
            // Let the colum scroll a bit longer when there's a system UI element at the bottom (e.g. on iPhoneX and later)
            SizedBox(height: MediaQuery.of(context).padding.bottom),
          ],
        ),
      ),
    );
  }
}
