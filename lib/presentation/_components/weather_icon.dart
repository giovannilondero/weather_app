// Flutter imports:
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
      // Slightly improve visibility of the images over the background
      // color: Colors.blue.shade900.withOpacity(0.1),
      color: Colors.brown.shade900.withOpacity(0.08),
      colorBlendMode: BlendMode.srcATop,
      // semanticLabel: ,
      // loadingBuilder: ,
      // errorBuilder: ,
    );
  }
}
