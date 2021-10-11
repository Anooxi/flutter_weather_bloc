import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:weather_app/models/weather_model.dart';
import 'package:weather_app/services/weather_service.dart';

part 'weather_event.dart';
part 'weather_state.dart';

class WeatherBloc extends Bloc<WeatherEvent, WeatherState> {

  final _weatherService = WeatherService();

  WeatherBloc() : super(InitialWeather()) {
    on<LoadWeatherEvent>((event, emit) async {
      emit(InitialWeather());
      try {
        final getWeather = await _weatherService.getWeather(event.city);
        emit(LoadedWeatherState(getWeather));
      } on Exception catch (e) {
        emit(FailedWeatherState(e));
      }
    });
  }

}
