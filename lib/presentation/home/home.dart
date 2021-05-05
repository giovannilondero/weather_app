// Flutter imports:
import 'package:flutter/material.dart';

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

  void navigateToDay(int index) {
    weatherDaysPageViewController.animateToPage(
      index,
      duration: const Duration(milliseconds: 300),
      curve: Curves.decelerate,
    );
  }

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
              // TODO: aggiungere pulsante per trovare posizione all'inizio, ma solo quando non ho ancora acconsentito
              // TODO: prendere subito la posizione corrente se posso
              const SearchBar(),
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
    );
  }
}
