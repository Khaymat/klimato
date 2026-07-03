import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../core/utils/weather_helper.dart';
import '../../domain/entities/city.dart';
import '../blocs/saved_city_bloc.dart';
import '../blocs/settings_bloc.dart';
import '../blocs/weather_bloc.dart';
import 'search_page.dart';
import 'forecast_page.dart';
import 'saved_cities_page.dart';
import 'settings_page.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final City defaultCity = City(id: 1, name: 'Jakarta', latitude: -6.2146, longitude: 106.8451, country: 'Indonesia');

  @override
  void initState() {
    super.initState();
    context.read<WeatherBloc>().add(FetchWeather(defaultCity));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Klimato'),
        actions: [
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (_) => SearchPage())),
          ),
        ],
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
              decoration: BoxDecoration(color: Colors.blue),
              child: Text('Klimato', style: TextStyle(color: Colors.white, fontSize: 24)),
            ),
            ListTile(
              leading: Icon(Icons.location_city),
              title: Text('Saved Cities'),
              onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => SavedCitiesPage())),
            ),
            ListTile(
              leading: Icon(Icons.settings),
              title: Text('Settings'),
              onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => SettingsPage())),
            ),
          ],
        ),
      ),
      body: BlocBuilder<WeatherBloc, WeatherState>(
        builder: (context, state) {
          if (state is WeatherLoading) {
            return Center(child: CircularProgressIndicator());
          } else if (state is WeatherError) {
            return Center(child: Text(state.message));
          } else if (state is WeatherLoaded) {
            return BlocBuilder<SettingsBloc, SettingsState>(
              builder: (context, settingsState) {
                bool isCelsius = true;
                if (settingsState is SettingsLoaded) {
                  isCelsius = settingsState.isCelsius;
                }

                return Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(state.city.name, style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold)),
                      Text(state.city.country, style: TextStyle(fontSize: 18, color: Colors.grey)),
                      SizedBox(height: 20),
                      Text(
                        WeatherHelper.getWeatherIcon(state.weather.weathercode),
                        style: TextStyle(fontSize: 80),
                      ),
                      SizedBox(height: 20),
                      Text(
                        WeatherHelper.formatTemp(state.weather.temperature, isCelsius),
                        style: TextStyle(fontSize: 48, fontWeight: FontWeight.bold),
                      ),
                      Text('Wind: ${state.weather.windspeed} km/h'),
                      SizedBox(height: 40),
                      ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (_) => ForecastPage(weather: state.weather, city: state.city)),
                          );
                        },
                        child: Text('View 7-Day Forecast'),
                      ),
                      ElevatedButton(
                        onPressed: () {
                          context.read<SavedCityBloc>().add(SaveCityEvent(state.city));
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('City saved!')));
                        },
                        child: Text('Save City'),
                      )
                    ],
                  ),
                );
              },
            );
          }
          return Container();
        },
      ),
    );
  }
}
