import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:weather_app/models/weather_model.dart';

Widget currentWeatherCard(WeatherModel weatherModel) {
  initializeDateFormatting('fr', null);

  City? city = weatherModel.city;
  Liste? current = weatherModel.list!.elementAt(0);
  DateTime parseDate = DateTime.fromMillisecondsSinceEpoch(current.dt!.toInt() * 1000);
  String formatedDate = DateFormat.yMMMMEEEEd('fr_FR').format(parseDate);
  formatedDate = formatedDate[0].toUpperCase() + formatedDate.substring(1);

  return Center(
    child: Column(
      children: [
        Text(city!.name.toString() + ", " + city.country.toString()),
        Text(formatedDate),
        Image(
          image: NetworkImage(current.weather![0].iconUrl),
        ),
        Text(current.main!.tempMin!.ceil().toString() +
            "°C - " +
            current.main!.tempMax!.ceil().toString() +
            "°C"),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Column(
                children: [
                  Text(current.wind!.speed!.ceil().toString() + " km/h"),
                  const Icon(
                    Icons.air,
                  ),
                ],
              ),
              Column(
                children: [
                  Text(current.main!.humidity.toString() + "%"),
                  const Icon(
                    Icons.water,
                  ),
                ],
              ),
              Column(
                children: [
                  Text(current.main!.feelsLike!.ceil().toString() + "°C"),
                  const Icon(
                    Icons.accessibility,
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    ),
  );
}
