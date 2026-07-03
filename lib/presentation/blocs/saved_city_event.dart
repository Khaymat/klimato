part of 'saved_city_bloc.dart';
abstract class SavedCityEvent extends Equatable {
  const SavedCityEvent();
  @override
  List<Object> get props => [];
}
class LoadSavedCities extends SavedCityEvent {}
class SaveCityEvent extends SavedCityEvent {
  final City city;
  const SaveCityEvent(this.city);
  @override
  List<Object> get props => [city];
}
class RemoveCityEvent extends SavedCityEvent {
  final int id;
  const RemoveCityEvent(this.id);
  @override
  List<Object> get props => [id];
}
