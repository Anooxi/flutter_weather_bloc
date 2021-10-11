part of 'weather_bloc.dart';

@immutable
abstract class WeatherState {}

// Loading
class InitialWeather extends WeatherState {}

// Loaded
class LoadedWeatherState extends WeatherState {
  final WeatherModel wm;
  LoadedWeatherState(this.wm);
}
// Failed
class FailedWeatherState extends WeatherState {
  final Exception err;
  FailedWeatherState(this.err);
}
