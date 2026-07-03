import 'package:dartz/dartz.dart';
import '../../core/error/failures.dart';
import '../../core/usecase/usecase.dart';
import '../entities/city.dart';
import '../repositories/weather_repository.dart';

class GetSavedCities implements UseCase<List<City>, NoParams> {
  final WeatherRepository repository;
  GetSavedCities(this.repository);
  @override
  Future<Either<Failure, List<City>>> call(NoParams params) async {
    return await repository.getSavedCities();
  }
}

class SaveCity implements UseCase<void, City> {
  final WeatherRepository repository;
  SaveCity(this.repository);
  @override
  Future<Either<Failure, void>> call(City city) async {
    return await repository.saveCity(city);
  }
}

class RemoveCity implements UseCase<void, int> {
  final WeatherRepository repository;
  RemoveCity(this.repository);
  @override
  Future<Either<Failure, void>> call(int id) async {
    return await repository.removeCity(id);
  }
}
