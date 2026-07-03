part of 'settings_bloc.dart';
abstract class SettingsEvent extends Equatable {
  const SettingsEvent();
  @override
  List<Object> get props => [];
}
class LoadSettings extends SettingsEvent {}
class ToggleUnit extends SettingsEvent {
  final bool isCelsius;
  const ToggleUnit(this.isCelsius);
  @override
  List<Object> get props => [isCelsius];
}
