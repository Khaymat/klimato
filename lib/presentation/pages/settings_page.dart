import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../blocs/settings_bloc.dart';

class SettingsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Pengaturan')),
      body: BlocBuilder<SettingsBloc, SettingsState>(
        builder: (context, state) {
          if (state is SettingsLoaded) {
            return ListView(
              children: [
                SwitchListTile(
                  title: Text('Satuan Suhu'),
                  subtitle: Text(state.isCelsius ? 'Celsius (Â°C)' : 'Fahrenheit (Â°F)'),
                  value: state.isCelsius,
                  onChanged: (value) {
                    context.read<SettingsBloc>().add(ToggleUnit(value));
                  },
                ),
              ],
            );
          }
          return Center(child: CircularProgressIndicator());
        },
      ),
    );
  }
}
