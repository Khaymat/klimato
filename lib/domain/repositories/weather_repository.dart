import 'package:dartz/dartz.dart';
import '../../core/error/failures.dart';
import '../entities/city.dart';
import '../entities/weather.dart';

abstract class WeatherRepository {
  Future<Either<Failure, List<City>>> searchCity(String query);
  Future<Either<Failure, Weather>> getWeather(double lat, double lon);

  Future<Either<Failure, List<City>>> getSavedCities();
  Future<Either<Failure, void>> saveCity(City city);
  Future<Either<Failure, void>> removeCity(int id);

  Future<Either<Failure, bool>> getIsCelsius();
  Future<Either<Failure, void>> setCelsius(bool isCelsius);
}
