// Flutter imports:
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:weather_app/application/weather/weather_cubit.dart';

// Project imports:
import 'package:weather_app/presentation/_components/weather_icon.dart';

class WeatherDaysList extends StatelessWidget {
  final ScrollController? controller;
  final int selectedIndex;
  final void Function(int) onTap;

  const WeatherDaysList({
    Key? key,
    required this.selectedIndex,
    required this.onTap,
    this.controller,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final bottomPadding =
        SizedBox(height: MediaQuery.of(context).padding.bottom);

    return context.watch<WeatherCubit>().state.maybeWhen(
          loaded: (days, city) => ListView.separated(
            controller: controller,
            scrollDirection: Axis.horizontal,
            itemCount: days.length,
            itemBuilder: (context, index) {
              final day = days.elementAt(index);
              return InkWell(
                onTap: () {
                  onTap(index);
                },
                child: Container(
                  color:
                      selectedIndex == index ? null : Colors.lightBlue.shade50,
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(DateFormat.E().format(day.date).toUpperCase()),
                      WeatherIcon(
                        code: day.icon!,
                        height: 75,
                        width: 75,
                      ),
                      Text('${day.tempMax.toInt()}° / ${day.tempMin.toInt()}'),
                      bottomPadding,
                    ],
                  ),
                ),
              );
            },
            separatorBuilder: (context, index) {
              return const VerticalDivider(width: 0);
            },
          ),
          orElse: () => const SizedBox.shrink(),
        );
  }
}
