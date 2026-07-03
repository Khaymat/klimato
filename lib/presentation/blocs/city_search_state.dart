part of 'city_search_bloc.dart';
abstract class CitySearchState extends Equatable {
  const CitySearchState();
  @override
  List<Object> get props => [];
}
class CitySearchInitial extends CitySearchState {}
class CitySearchLoading extends CitySearchState {}
class CitySearchLoaded extends CitySearchState {
  final List<City> cities;
  const CitySearchLoaded(this.cities);
  @override
  List<Object> get props => [cities];
}
class CitySearchError extends CitySearchState {
  final String message;
  const CitySearchError(this.message);
  @override
  List<Object> get props => [message];
}
