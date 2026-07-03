import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import '../../domain/entities/city.dart';
import '../../domain/usecases/search_city.dart';

part 'city_search_event.dart';
part 'city_search_state.dart';

class CitySearchBloc extends Bloc<CitySearchEvent, CitySearchState> {
  final SearchCity searchCity;

  CitySearchBloc({required this.searchCity}) : super(CitySearchInitial()) {
    on<SearchCityEvent>((event, emit) async {
      emit(CitySearchLoading());
      final result = await searchCity(event.query);
      result.fold(
        (failure) => emit(CitySearchError(failure.message)),
        (cities) => emit(CitySearchLoaded(cities)),
      );
    });
  }
}
