import 'package:dartz/dartz.dart';
import '../../core/error/failures.dart';
import '../../core/usecase/usecase.dart';
import '../repositories/weather_repository.dart';

class GetSettings implements UseCase<bool, NoParams> {
  final WeatherRepository repository;
  GetSettings(this.repository);
  @override
  Future<Either<Failure, bool>> call(NoParams params) async {
    return await repository.getIsCelsius();
  }
}

class SaveSettings implements UseCase<void, bool> {
  final WeatherRepository repository;
  SaveSettings(this.repository);
  @override
  Future<Either<Failure, void>> call(bool isCelsius) async {
    return await repository.setCelsius(isCelsius);
  }
}
