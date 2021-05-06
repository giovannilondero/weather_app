// Flutter imports:
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_app/application/weather/weather_cubit.dart';

// Project imports:
import 'package:weather_app/presentation/home/components/search_bar.dart';
import 'package:weather_app/presentation/home/components/weather_days_list.dart';
import 'package:weather_app/presentation/home/components/weather_days_pageview.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final weatherDaysPageViewController = PageController();
  final weatherDaysListController = ScrollController();
  int selectedDayIndex = 0;

  @override
  void initState() {
    super.initState();
    weatherDaysPageViewController.addListener(updateSelectedDayIndex);
  }

  @override
  void dispose() {
    weatherDaysPageViewController.removeListener(updateSelectedDayIndex);
    super.dispose();
  }

  void updateSelectedDayIndex() {
    final index = weatherDaysPageViewController.page;
    if (index != null && index.round() != selectedDayIndex) {
      setState(() {
        selectedDayIndex = index.round();
      });
    }
  }

  void resetSelectedDayIndex() {
    setState(() {
      selectedDayIndex = 0;
    });
  }

  void navigateToDay(int index) {
    weatherDaysPageViewController.animateToPage(
      index,
      duration: const Duration(milliseconds: 300),
      curve: Curves.decelerate,
    );
  }

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    const searchInputHeight = 50; // TODO: move this const

    return BlocListener<WeatherCubit, WeatherState>(
      listener: (context, state) {
        // When the state changes in anyway, reset the selectedDayIndex to avoid
        // having a selectedDay in the bottom list different than the details in PageView.
        resetSelectedDayIndex();
      },
      child: Scaffold(
        appBar: PreferredSize(
          preferredSize: const Size(double.infinity, 200),
          child: Padding(
            padding: EdgeInsets.only(top: mediaQuery.padding.top),
            child: const SearchBar(),
          ),
        ),
        body: SafeArea(
          bottom: false, // set at the bottom of the scroll view
          child: DefaultTextStyle(
            style: const TextStyle(color: Color(0xff3d4b50)),
            child: SingleChildScrollView(
              child: SizedBox(
                height: mediaQuery.size.height -
                    mediaQuery.padding.top -
                    searchInputHeight,
                child: Column(
                  children: [
                    Expanded(
                      flex: 3,
                      child: WeatherDaysPageView(
                        controller: weatherDaysPageViewController,
                      ),
                    ),
                    Expanded(
                      child: WeatherDaysList(
                        selectedIndex: selectedDayIndex,
                        controller: weatherDaysListController,
                        onTap: navigateToDay,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
