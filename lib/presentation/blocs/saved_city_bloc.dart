import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import '../../core/usecase/usecase.dart';
import '../../domain/entities/city.dart';
import '../../domain/usecases/manage_cities.dart';

part 'saved_city_event.dart';
part 'saved_city_state.dart';

class SavedCityBloc extends Bloc<SavedCityEvent, SavedCityState> {
  final GetSavedCities getSavedCities;
  final SaveCity saveCity;
  final RemoveCity removeCity;

  SavedCityBloc({
    required this.getSavedCities,
    required this.saveCity,
    required this.removeCity,
  }) : super(SavedCityInitial()) {
    on<LoadSavedCities>((event, emit) async {
      emit(SavedCityLoading());
      final result = await getSavedCities(NoParams());
      result.fold(
        (failure) => emit(SavedCityError(failure.message)),
        (cities) => emit(SavedCityLoaded(cities)),
      );
    });

    on<SaveCityEvent>((event, emit) async {
      await saveCity(event.city);
      add(LoadSavedCities());
    });

    on<RemoveCityEvent>((event, emit) async {
      await removeCity(event.id);
      add(LoadSavedCities());
    });
  }
}
