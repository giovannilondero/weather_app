// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:flutter_bloc/flutter_bloc.dart';

// Project imports:
import 'package:weather_app/application/weather/weather_cubit.dart';
import 'package:weather_app/presentation/home/components/day_details.dart';
import 'package:weather_app/presentation/home/components/search_bar.dart';

class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        bottom: false, // set at the bottom of the scroll view
        child: DefaultTextStyle(
          // TODO: move color somewhere else
          style: const TextStyle(color: Color(0xff3d4b50)),
          child: Column(
            children: [
              // TODO: colonna con 3 elementi (search, giorno, lista giorni)
              // TODO: UI giorno
              // TODO: UI lista giorni
              // TODO: controller per cambiare i giorni
              // TODO: separare bene i widget
              // TODO: aggiungere pulsante per trovare posizione all'inizio, ma solo quando non ho ancora acconsentito
              // TODO: prendere subito la posizione corrente se posso
              const SearchBar(),
              context.watch<WeatherCubit>().state.maybeWhen(
                    loaded: (days, city) => Expanded(
                      child: PageView(
                        children: days
                            .map(
                              (day) => TodayDetails(
                                day: day,
                                city: city,
                              ),
                            )
                            .toList(),
                      ),
                    ),
                    // WeatherDaysList(days: nextDays),
                    loading: () => const CircularProgressIndicator(),
                    orElse: () => const SizedBox.shrink(),
                  ),
              // Let the colum scroll a bit longer when there's a system UI element at the bottom (e.g. on iPhoneX and later)
              SizedBox(height: MediaQuery.of(context).padding.bottom),
            ],
          ),
        ),
      ),
    );
  }
}
