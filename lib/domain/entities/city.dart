import 'package:equatable/equatable.dart';

class City extends Equatable {
  final int id;
  final String name;
  final double latitude;
  final double longitude;
  final String country;

  const City({
    required this.id,
    required this.name,
    required this.latitude,
    required this.longitude,
    required this.country,
  });

  @override
  List<Object?> get props => [id, name, latitude, longitude, country];
}
