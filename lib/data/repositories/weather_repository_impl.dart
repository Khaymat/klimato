import 'package:dartz/dartz.dart';
import '../../core/error/exceptions.dart';
import '../../core/error/failures.dart';
import '../../domain/entities/city.dart';
import '../../domain/entities/weather.dart';
import '../../domain/repositories/weather_repository.dart';
import '../datasources/weather_local_data_source.dart';
import '../datasources/weather_remote_data_source.dart';
import '../models/city_model.dart';

class WeatherRepositoryImpl implements WeatherRepository {
  final WeatherRemoteDataSource remoteDataSource;
  final WeatherLocalDataSource localDataSource;

  WeatherRepositoryImpl({
    required this.remoteDataSource,
    required this.localDataSource,
  });

  @override
  Future<Either<Failure, List<City>>> searchCity(String query) async {
    try {
      final cities = await remoteDataSource.searchCity(query);
      return Right(cities);
    } on ServerException {
      return Left(ServerFailure('Failed to search cities'));
    }
  }

  @override
  Future<Either<Failure, Weather>> getWeather(double lat, double lon) async {
    try {
      final weather = await remoteDataSource.getWeather(lat, lon);
      return Right(weather);
    } on ServerException {
      return Left(ServerFailure('Failed to get weather'));
    } catch (e) {
      return Left(ServerFailure('Unexpected error: ${e.toString()}'));
    }
  }

  @override
  Future<Either<Failure, List<City>>> getSavedCities() async {
    try {
      final cities = await localDataSource.getSavedCities();
      return Right(cities);
    } on CacheException {
      return Left(CacheFailure('Failed to load saved cities'));
    }
  }

  @override
  Future<Either<Failure, void>> saveCity(City city) async {
    try {
      await localDataSource.saveCity(CityModel(
        id: city.id,
        name: city.name,
        latitude: city.latitude,
        longitude: city.longitude,
        country: city.country,
      ));
      return Right(null);
    } on CacheException {
      return Left(CacheFailure('Failed to save city'));
    }
  }

  @override
  Future<Either<Failure, void>> removeCity(int id) async {
    try {
      await localDataSource.removeCity(id);
      return Right(null);
    } on CacheException {
      return Left(CacheFailure('Failed to remove city'));
    }
  }

  @override
  Future<Either<Failure, bool>> getIsCelsius() async {
    try {
      final isCelsius = await localDataSource.getIsCelsius();
      return Right(isCelsius);
    } on CacheException {
      return Left(CacheFailure('Failed to load settings'));
    }
  }

  @override
  Future<Either<Failure, void>> setCelsius(bool isCelsius) async {
    try {
      await localDataSource.setCelsius(isCelsius);
      return Right(null);
    } on CacheException {
      return Left(CacheFailure('Failed to save settings'));
    }
  }
}
