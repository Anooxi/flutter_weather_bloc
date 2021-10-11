import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_app/bloc/weather_bloc.dart';
import 'package:weather_app/widgets/current_weather_card.dart';
import 'package:weather_app/widgets/forecasted_weather_card.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _text = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("REITER Maxime - Weather App"),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: Column(
                children: [
                  TextField(
                    controller: _text,
                    decoration: const InputDecoration(
                      labelText: "Entrez une ville",
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      if (_text.text.isNotEmpty) {
                        context
                            .read<WeatherBloc>()
                            .add(LoadWeatherEvent(_text.text));
                      }
                    },
                    child: const Text("Envoyer"),
                  ),
                ],
              ),
            ),
            BlocBuilder<WeatherBloc, WeatherState>(
              builder: (context, state) {
                if (state is InitialWeather) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                } else if (state is LoadedWeatherState) {
                  return Column(children: [
                    const Padding(
                        padding:
                            EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                        child: Text(
                          "Météo Actuelle",
                          style: TextStyle(
                            fontSize: 40,
                          ),
                        )),
                    currentWeatherCard(state.wm),
                    const Padding(
                        padding:
                            EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                        child: Text(
                          "Prévisions",
                          style: TextStyle(
                            fontSize: 40,
                          ),
                        )),
                    forecastedListWeather(state.wm),
                  ]);
                } else if (state is FailedWeatherState) {
                  return Center(
                    child: Text(state.err.toString()),
                  );
                } else {
                  return Container();
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
