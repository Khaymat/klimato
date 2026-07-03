part of 'saved_city_bloc.dart';
abstract class SavedCityState extends Equatable {
  const SavedCityState();
  @override
  List<Object> get props => [];
}
class SavedCityInitial extends SavedCityState {}
class SavedCityLoading extends SavedCityState {}
class SavedCityLoaded extends SavedCityState {
  final List<City> cities;
  const SavedCityLoaded(this.cities);
  @override
  List<Object> get props => [cities];
}
class SavedCityError extends SavedCityState {
  final String message;
  const SavedCityError(this.message);
  @override
  List<Object> get props => [message];
}
