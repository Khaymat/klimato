import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../injection_container.dart';
import '../blocs/city_search_bloc.dart';
import '../blocs/weather_bloc.dart';

class SearchPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => sl<CitySearchBloc>(),
      child: Scaffold(
        appBar: AppBar(title: Text('Search City')),
        body: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Builder(
                builder: (context) {
                  return TextField(
                    decoration: InputDecoration(
                      labelText: 'City Name',
                      border: OutlineInputBorder(),
                      suffixIcon: Icon(Icons.search),
                    ),
                    onSubmitted: (query) {
                      context.read<CitySearchBloc>().add(SearchCityEvent(query));
                    },
                  );
                }
              ),
            ),
            Expanded(
              child: BlocBuilder<CitySearchBloc, CitySearchState>(
                builder: (context, state) {
                  if (state is CitySearchLoading) {
                    return Center(child: CircularProgressIndicator());
                  } else if (state is CitySearchError) {
                    return Center(child: Text(state.message));
                  } else if (state is CitySearchLoaded) {
                    if (state.cities.isEmpty) return Center(child: Text('No cities found'));
                    return ListView.builder(
                      itemCount: state.cities.length,
                      itemBuilder: (context, index) {
                        final city = state.cities[index];
                        return ListTile(
                          title: Text(city.name),
                          subtitle: Text(city.country),
                          onTap: () {

                            BlocProvider.of<WeatherBloc>(context).add(FetchWeather(city));
                            Navigator.pop(context);
                          },
                        );
                      },
                    );
                  }
                  return Center(child: Text('Enter a city name'));
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
