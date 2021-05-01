import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class WeatherDay extends StatelessWidget {
  final DateTime dateTime;
  final Widget? icon;
  final double? minTemp;
  final double? maxTemp;

  const WeatherDay({
    Key? key,
    required this.dateTime,
    this.icon,
    this.minTemp,
    this.maxTemp,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(10),
      padding: const EdgeInsets.symmetric(horizontal: 24),
      decoration: BoxDecoration(
        color: Colors.grey[300],
        borderRadius: BorderRadius.circular(30),
      ),
      child: Row(
        children: [
          Expanded(
            flex: 3,
            child: Text(DateFormat('E, d MMM').format(dateTime)),
          ),
          if (icon != null) Expanded(child: icon!),
          Expanded(
            flex: 2,
            child: Text(
              '${minTemp ?? '-'}° / ${maxTemp ?? '-'} °C',
              textAlign: TextAlign.right,
            ),
          ),
        ],
      ),
    );
  }
}
