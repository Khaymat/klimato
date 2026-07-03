import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import '../../core/usecase/usecase.dart';
import '../../domain/usecases/manage_settings.dart';

part 'settings_event.dart';
part 'settings_state.dart';

class SettingsBloc extends Bloc<SettingsEvent, SettingsState> {
  final GetSettings getSettings;
  final SaveSettings saveSettings;

  SettingsBloc({required this.getSettings, required this.saveSettings}) : super(SettingsInitial()) {
    on<LoadSettings>((event, emit) async {
      final result = await getSettings(NoParams());
      result.fold(
        (failure) => null,
        (isCelsius) => emit(SettingsLoaded(isCelsius)),
      );
    });

    on<ToggleUnit>((event, emit) async {
      await saveSettings(event.isCelsius);
      emit(SettingsLoaded(event.isCelsius));
    });
  }
}
