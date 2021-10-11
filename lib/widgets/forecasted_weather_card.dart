import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';
import 'package:weather_app/models/weather_model.dart';

Widget forecastedWeatherCard(Liste weather) {

  initializeDateFormatting('fr', null);
  DateTime parseDate = DateTime.fromMillisecondsSinceEpoch(weather.dt!.toInt() * 1000);
  String formatedDate = DateFormat.EEEE('fr_FR').format(parseDate);
  formatedDate = formatedDate[0].toUpperCase() + formatedDate.substring(1);

  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 10),
    child: Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20.0),
      ),
      elevation: 5,
      child: SizedBox(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          child: Column(
            children: [
              Text(formatedDate),
              Image(
                image: NetworkImage(weather.weather![0].iconUrl),
              ),
              Text(weather.main!.tempMin!.ceil().toString() +
                  "°C - " +
                  weather.main!.tempMax!.ceil().toString() +
                  "°C"),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 5,),
                      child: Column(
                        children: [
                          Text(weather.wind!.speed!.ceil().toString() + " km/h"),
                          const Icon(
                            Icons.air,
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 5,),
                      child: Column(
                        children: [
                          Text(weather.main!.humidity.toString() + "%"),
                          const Icon(
                            Icons.water,
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 5,),
                      child: Column(
                        children: [
                          Text(weather.main!.feelsLike!.ceil().toString() + "°C"),
                          const Icon(
                            Icons.accessibility,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    ),
  );
}

Widget forecastedListWeather(WeatherModel weatherModel){
  return SizedBox(
    height: 250,
    child: ListView(
      scrollDirection: Axis.horizontal,
      children: childCall(weatherModel),
    ),
  );
}

List<Widget> childCall(WeatherModel weatherModel){
  List<Widget> liste = [];

  for (var element in weatherModel.list!) {
    DateTime parseDate = DateTime.fromMillisecondsSinceEpoch(element.dt!.toInt() * 1000);
    if(parseDate.hour == 11){
      liste.add(forecastedWeatherCard(element));
    }
  }
  return liste;
}