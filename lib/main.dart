import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:weather_app/bloc/weather_bloc.dart';
import 'package:weather_app/views/main_page.dart';

Future<void> main() async {
  await dotenv.load(fileName : '.env');
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'REITER Maxime - 21604458 - Weather App',
      theme: ThemeData.light(),
      darkTheme: ThemeData.dark(),
      home: BlocProvider<WeatherBloc>(
        create: (context) => WeatherBloc(),
          child: const HomePage()
      ),
    );
  }


}

