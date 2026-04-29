import 'package:equatable/equatable.dart';

class CitySearchResult extends Equatable {
  final int id;
  final String name;
  final String country;
  final String? admin1;
  final double latitude;
  final double longitude;
  final String? timezone;

  const CitySearchResult({
    required this.id,
    required this.name,
    required this.country,
    this.admin1,
    required this.latitude,
    required this.longitude,
    this.timezone,
  });

  String get subtitle {
    if (admin1 != null && admin1!.isNotEmpty) {
      return country.isNotEmpty ? '$admin1 · $country' : admin1!;
    }
    return country;
  }

  @override
  List<Object?> get props => [id, name, country, admin1, latitude, longitude, timezone];
}
