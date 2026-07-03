import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../blocs/saved_city_bloc.dart';
import '../blocs/weather_bloc.dart';

class SavedCitiesPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Kota Tersimpan')),
      body: BlocBuilder<SavedCityBloc, SavedCityState>(
        builder: (context, state) {
          if (state is SavedCityLoading) {
            return Center(child: CircularProgressIndicator());
          } else if (state is SavedCityError) {
            return Center(child: Text(state.message));
          } else if (state is SavedCityLoaded) {
            if (state.cities.isEmpty) return Center(child: Text('Belum ada kota tersimpan.'));
            return ListView.builder(
              itemCount: state.cities.length,
              itemBuilder: (context, index) {
                final city = state.cities[index];
                return ListTile(
                  title: Text(city.name),
                  subtitle: Text(city.country),
                  trailing: IconButton(
                    icon: Icon(Icons.delete, color: Colors.red),
                    onPressed: () {
                      context.read<SavedCityBloc>().add(RemoveCityEvent(city.id));
                    },
                  ),
                  onTap: () {
                    BlocProvider.of<WeatherBloc>(context).add(FetchWeather(city));
                    Navigator.pop(context);
                  },
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
