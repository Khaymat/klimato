import 'package:dartz/dartz.dart';
import '../../core/error/failures.dart';
import '../../core/usecase/usecase.dart';
import '../entities/city.dart';
import '../repositories/weather_repository.dart';

class SearchCity implements UseCase<List<City>, String> {
  final WeatherRepository repository;

  SearchCity(this.repository);

  @override
  Future<Either<Failure, List<City>>> call(String query) async {
    return await repository.searchCity(query);
  }
}
