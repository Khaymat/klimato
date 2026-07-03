part of 'weather_bloc.dart';
abstract class WeatherState extends Equatable {
  const WeatherState();
  @override
  List<Object> get props => [];
}
class WeatherInitial extends WeatherState {}
class WeatherLoading extends WeatherState {}
class WeatherLoaded extends WeatherState {
  final Weather weather;
  final City city;
  const WeatherLoaded(this.weather, this.city);
  @override
  List<Object> get props => [weather, city];
}
class WeatherError extends WeatherState {
  final String message;
  const WeatherError(this.message);
  @override
  List<Object> get props => [message];
}
