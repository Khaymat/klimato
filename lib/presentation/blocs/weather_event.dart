part of 'weather_bloc.dart';
abstract class WeatherEvent extends Equatable {
  const WeatherEvent();
  @override
  List<Object> get props => [];
}
class FetchWeather extends WeatherEvent {
  final City city;
  const FetchWeather(this.city);
  @override
  List<Object> get props => [city];
}
