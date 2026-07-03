import '../../domain/entities/weather.dart';

class WeatherModel extends Weather {
  const WeatherModel({
    required super.temperature,
    required super.windspeed,
    required super.weathercode,
    required super.daily,
  });

  static int _mapCode(int wttrCode) {
    if (wttrCode == 113) return 0;
    if (wttrCode == 116) return 2;
    if (wttrCode == 119 || wttrCode == 122) return 3;
    if (wttrCode >= 143 && wttrCode <= 260) return 45;
    if (wttrCode >= 263 && wttrCode <= 284) return 51;
    if (wttrCode >= 293 && wttrCode <= 308) return 61;
    if (wttrCode >= 311 && wttrCode <= 317) return 66;
    if (wttrCode >= 320 && wttrCode <= 338) return 71;
    if (wttrCode >= 350 && wttrCode <= 377) return 80;
    if (wttrCode >= 386 && wttrCode <= 395) return 95;
    return wttrCode;
  }

  factory WeatherModel.fromJson(Map<String, dynamic> json) {
    final currentList = json['current_condition'] as List?;
    final dailyListJson = json['weather'] as List?;

    List<DailyForecastModel> dailyList = [];
    if (dailyListJson != null) {
      for (final day in dailyListJson) {
        final hourly = day['hourly'] as List?;
        int dayCode = 0;
        if (hourly != null && hourly.isNotEmpty) {
          dayCode = int.tryParse(hourly[4]?['weatherCode']?.toString() ?? '') ?? 0;
        }
        dailyList.add(DailyForecastModel(
          time: day['date'] as String? ?? '',
          maxTemp: double.tryParse(day['maxtempC']?.toString() ?? '0') ?? 0,
          minTemp: double.tryParse(day['mintempC']?.toString() ?? '0') ?? 0,
          weathercode: _mapCode(dayCode),
        ));
      }
    }

    final current = currentList?.isNotEmpty == true ? currentList![0] : null;
    return WeatherModel(
      temperature: double.tryParse(current?['temp_C']?.toString() ?? '0') ?? 0,
      windspeed: double.tryParse(current?['windspeedKmph']?.toString() ?? '0') ?? 0,
      weathercode: _mapCode(int.tryParse(current?['weatherCode']?.toString() ?? '0') ?? 0),
      daily: dailyList,
    );
  }
}

class DailyForecastModel extends DailyForecast {
  const DailyForecastModel({
    required super.time,
    required super.maxTemp,
    required super.minTemp,
    required super.weathercode,
  });
}
