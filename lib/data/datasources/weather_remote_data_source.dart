import 'dart:convert';
import 'package:http/http.dart' as http;
import '../../core/error/exceptions.dart';
import '../models/city_model.dart';
import '../models/weather_model.dart';

abstract class WeatherRemoteDataSource {
  Future<List<CityModel>> searchCity(String query);
  Future<WeatherModel> getWeather(double lat, double lon);
}

class WeatherRemoteDataSourceImpl implements WeatherRemoteDataSource {
  final http.Client client;

  WeatherRemoteDataSourceImpl({required this.client});

  @override
  Future<List<CityModel>> searchCity(String query) async {
    final response = await client.get(Uri.parse(
        'https://geocoding-api.open-meteo.com/v1/search?name=$query&count=10&language=en&format=json'));

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      if (data['results'] == null) return [];
      return (data['results'] as List).map((e) => CityModel.fromJson(e)).toList();
    } else {
      throw ServerException();
    }
  }

  @override
  Future<WeatherModel> getWeather(double lat, double lon) async {
    final response = await client.get(Uri.parse(
        'https://wttr.in/$lat,$lon?format=j1'));

    if (response.statusCode == 200) {
      return WeatherModel.fromJson(json.decode(response.body));
    } else {
      throw ServerException();
    }
  }
}
