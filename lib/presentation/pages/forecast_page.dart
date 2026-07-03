import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../core/utils/weather_helper.dart';
import '../../domain/entities/city.dart';
import '../../domain/entities/weather.dart';
import '../blocs/settings_bloc.dart';

class ForecastPage extends StatelessWidget {
  final Weather weather;
  final City city;

  const ForecastPage({required this.weather, required this.city});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Prakiraan ${city.name}')),
      body: BlocBuilder<SettingsBloc, SettingsState>(
        builder: (context, settingsState) {
          bool isCelsius = true;
          if (settingsState is SettingsLoaded) {
            isCelsius = settingsState.isCelsius;
          }
          return ListView.builder(
            itemCount: weather.daily.length,
            itemBuilder: (context, index) {
              final daily = weather.daily[index];
              return ListTile(
                leading: Text(
                  WeatherHelper.getWeatherIcon(daily.weathercode),
                  style: TextStyle(fontSize: 32),
                ),
                title: Text(daily.time),
                subtitle: Text('Maks: ${WeatherHelper.formatTemp(daily.maxTemp, isCelsius)} / Min: ${WeatherHelper.formatTemp(daily.minTemp, isCelsius)}'),
              );
            },
          );
        },
      ),
    );
  }
}
