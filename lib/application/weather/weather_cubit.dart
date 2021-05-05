// Package imports:
import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

// Project imports:
import 'package:weather_app/domain/day_weather.dart';
import 'package:weather_app/domain/full_day_weather_details.dart';
import 'package:weather_app/domain/i_weather_repository.dart';
import 'package:weather_app/domain/weather_api_response.dart';

part 'weather_state.dart';
part 'weather_cubit.freezed.dart';

class WeatherCubit extends Cubit<WeatherState> {
  final IWeatherRepository weatherRepository;

  WeatherCubit(this.weatherRepository) : super(const WeatherState.initial());

  Future<void> loadByCityName(String cityName) async {
    emit(const WeatherState.loading());

    final response = await weatherRepository.getWeatherByCity(name: cityName);

    // TODO: gestire errori
    // TODO: gestire geolocation

    emitWithApiResponse(response);
  }

  void emitWithApiResponse(WeatherApiResponse response) {
    // * initially this was used to group the 3h-info for every day, but
    // * a change in the UI made this useless in the end
    final dayWeatherDetailsList = response.list
        // Group data for every day
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
        // Create a FullDayWeatherDetails which contains all the grouped data for every day
        .entries
        .map((e) => FullDayWeatherDetails(
              date: e.key,
              dayDetails: e.value,
            ))
        .toList();

    emit(WeatherState.loaded(
      days: dayWeatherDetailsList,
      city: response.city,
    ));
  }
}
