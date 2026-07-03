import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import '../../core/error/failures.dart';
import '../../core/usecase/usecase.dart';
import '../entities/weather.dart';
import '../repositories/weather_repository.dart';

class GetWeather implements UseCase<Weather, LocationParams> {
  final WeatherRepository repository;

  GetWeather(this.repository);

  @override
  Future<Either<Failure, Weather>> call(LocationParams params) async {
    return await repository.getWeather(params.lat, params.lon);
  }
}

class LocationParams extends Equatable {
  final double lat;
  final double lon;

  const LocationParams({required this.lat, required this.lon});

  @override
  List<Object> get props => [lat, lon];
}
