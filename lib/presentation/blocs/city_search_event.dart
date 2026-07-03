part of 'city_search_bloc.dart';
abstract class CitySearchEvent extends Equatable {
  const CitySearchEvent();
  @override
  List<Object> get props => [];
}
class SearchCityEvent extends CitySearchEvent {
  final String query;
  const SearchCityEvent(this.query);
  @override
  List<Object> get props => [query];
}
