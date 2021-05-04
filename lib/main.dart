// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:flutter_dotenv/flutter_dotenv.dart' as dot_env;

// Project imports:
import 'package:weather_app/presentation/_core/app.dart';

Future<void> main() async {
  // * For the purpose of the project, only the default file '.env' wil be used.
  await dot_env.load();

  runApp(const App());
}
