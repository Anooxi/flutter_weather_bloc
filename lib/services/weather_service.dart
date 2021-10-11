import 'dart:convert';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:weather_app/models/weather_model.dart';
import 'package:http/http.dart' as http;

class WeatherService {
  Future<WeatherModel> getWeather(String city) async {
    String apikey = dotenv.get("OPEN_WEATHER_APP_API_KEY");
    Uri parse = Uri.parse("https://api.openweathermap.org/data/2.5/forecast?q=" + city + "&appid=" + apikey + "&lang=fr" + "&units=metric");
    var response = await http.get(parse);

    if( response.statusCode == 200){
      return WeatherModel.fromJson(jsonDecode(response.body));
    } else {
      throw Exception("Erreur lors de la récupération de la météo" + response.body);
    }
  }
}