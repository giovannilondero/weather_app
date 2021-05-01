import 'package:flutter/material.dart';

class WeatherIcon extends StatelessWidget {
  final String code;
  final double? width;
  final double? height;

  const WeatherIcon({
    Key? key,
    required this.code,
    this.width,
    this.height,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Image.network(
      'https://openweathermap.org/img/wn/$code@2x.png',
      width: width,
      height: height,
    );
  }
}
