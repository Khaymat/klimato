import 'package:equatable/equatable.dart';

class Weather extends Equatable {
  final double temperature;
  final double windspeed;
  final int weathercode;
  final List<DailyForecast> daily;

  const Weather({
    required this.temperature,
    required this.windspeed,
    required this.weathercode,
    required this.daily,
  });

  @override
  List<Object?> get props => [temperature, windspeed, weathercode, daily];
}

class DailyForecast extends Equatable {
  final String time;
  final double maxTemp;
  final double minTemp;
  final int weathercode;

  const DailyForecast({
    required this.time,
    required this.maxTemp,
    required this.minTemp,
    required this.weathercode,
  });

  @override
  List<Object?> get props => [time, maxTemp, minTemp, weathercode];
}
