part of 'settings_bloc.dart';
abstract class SettingsState extends Equatable {
  const SettingsState();
  @override
  List<Object> get props => [];
}
class SettingsInitial extends SettingsState {}
class SettingsLoaded extends SettingsState {
  final bool isCelsius;
  const SettingsLoaded(this.isCelsius);
  @override
  List<Object> get props => [isCelsius];
}
