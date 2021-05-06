// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:flutter_bloc/flutter_bloc.dart';

// Project imports:
import 'package:weather_app/application/weather/weather_cubit.dart';
import 'package:weather_app/presentation/home/components/day_details.dart';

class WeatherDaysPageView extends StatelessWidget {
  final PageController? controller;

  const WeatherDaysPageView({
    Key? key,
    this.controller,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return context.watch<WeatherCubit>().state.maybeWhen(
          loaded: (days, city) => Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const SizedBox(height: 24),
              Text(
                city.name.toUpperCase(),
                style: Theme.of(context).textTheme.headline6,
              ),
              Expanded(
                child: PageView(
                  controller: controller,
                  children: [
                    for (final day in days)
                      TodayDetails(
                        day: day,
                        city: city,
                      ),
                  ],
                ),
              ),
            ],
          ),
          // WeatherDaysList(days: nextDays),
          loading: () => const Center(child: CircularProgressIndicator()),
          orElse: () => const SizedBox.shrink(),
        );
  }
}
