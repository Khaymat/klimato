import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import 'data/datasources/weather_local_data_source.dart';
import 'data/datasources/weather_remote_data_source.dart';
import 'data/repositories/weather_repository_impl.dart';
import 'domain/repositories/weather_repository.dart';
import 'domain/usecases/get_weather.dart';
import 'domain/usecases/manage_cities.dart';
import 'domain/usecases/manage_settings.dart';
import 'domain/usecases/search_city.dart';
import 'presentation/blocs/city_search_bloc.dart';
import 'presentation/blocs/saved_city_bloc.dart';
import 'presentation/blocs/settings_bloc.dart';
import 'presentation/blocs/weather_bloc.dart';

final sl = GetIt.instance;

Future<void> init() async {

  sl.registerFactory(() => WeatherBloc(getWeather: sl()));
  sl.registerFactory(() => CitySearchBloc(searchCity: sl()));
  sl.registerFactory(() => SavedCityBloc(
        getSavedCities: sl(),
        saveCity: sl(),
        removeCity: sl(),
      ));
  sl.registerFactory(() => SettingsBloc(
        getSettings: sl(),
        saveSettings: sl(),
      ));


  sl.registerLazySingleton(() => GetWeather(sl()));
  sl.registerLazySingleton(() => SearchCity(sl()));
  sl.registerLazySingleton(() => GetSavedCities(sl()));
  sl.registerLazySingleton(() => SaveCity(sl()));
  sl.registerLazySingleton(() => RemoveCity(sl()));
  sl.registerLazySingleton(() => GetSettings(sl()));
  sl.registerLazySingleton(() => SaveSettings(sl()));


  sl.registerLazySingleton<WeatherRepository>(() => WeatherRepositoryImpl(
        remoteDataSource: sl(),
        localDataSource: sl(),
      ));


  sl.registerLazySingleton<WeatherRemoteDataSource>(
      () => WeatherRemoteDataSourceImpl(client: sl()));
  sl.registerLazySingleton<WeatherLocalDataSource>(
      () => WeatherLocalDataSourceImpl(sharedPreferences: sl()));


  sl.registerLazySingleton(() => http.Client());
  final sharedPreferences = await SharedPreferences.getInstance();
  sl.registerLazySingleton(() => sharedPreferences);
}
