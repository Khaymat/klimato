import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/city_model.dart';

abstract class WeatherLocalDataSource {
  Future<List<CityModel>> getSavedCities();
  Future<void> saveCity(CityModel city);
  Future<void> removeCity(int id);
  Future<bool> getIsCelsius();
  Future<void> setCelsius(bool isCelsius);
}

class WeatherLocalDataSourceImpl implements WeatherLocalDataSource {
  final SharedPreferences sharedPreferences;

  WeatherLocalDataSourceImpl({required this.sharedPreferences});

  @override
  Future<List<CityModel>> getSavedCities() async {
    final jsonString = sharedPreferences.getString('CACHED_CITIES');
    if (jsonString != null) {
      final List data = json.decode(jsonString);
      return data.map((e) => CityModel.fromJson(e)).toList();
    }
    return [];
  }

  @override
  Future<void> saveCity(CityModel city) async {
    final cities = await getSavedCities();
    if (!cities.any((c) => c.id == city.id)) {
      cities.add(city);
      sharedPreferences.setString(
          'CACHED_CITIES', json.encode(cities.map((e) => e.toJson()).toList()));
    }
  }

  @override
  Future<void> removeCity(int id) async {
    final cities = await getSavedCities();
    cities.removeWhere((c) => c.id == id);
    sharedPreferences.setString(
        'CACHED_CITIES', json.encode(cities.map((e) => e.toJson()).toList()));
  }

  @override
  Future<bool> getIsCelsius() async {
    return sharedPreferences.getBool('IS_CELSIUS') ?? true;
  }

  @override
  Future<void> setCelsius(bool isCelsius) async {
    sharedPreferences.setBool('IS_CELSIUS', isCelsius);
  }
}
