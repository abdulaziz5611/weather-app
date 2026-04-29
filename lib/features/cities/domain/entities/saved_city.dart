import 'package:equatable/equatable.dart';

class SavedCity extends Equatable {
  final String id;
  final String name;
  final String country;
  final String? admin1;
  final double latitude;
  final double longitude;
  final String? timezone;
  final bool isCurrentLocation;

  const SavedCity({
    required this.id,
    required this.name,
    required this.country,
    this.admin1,
    required this.latitude,
    required this.longitude,
    this.timezone,
    this.isCurrentLocation = false,
  });

  @override
  List<Object?> get props => [
        id,
        name,
        country,
        admin1,
        latitude,
        longitude,
        timezone,
        isCurrentLocation,
      ];
}
