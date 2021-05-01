import 'package:flutter/material.dart';
import 'package:weather_app/presentation/_core/app.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart' as dot_env;

Future<void> main() async {
  // * For the purpose of the project, only the default file '.env' wil be used.
  await dot_env.load();

  runApp(const App());
}
