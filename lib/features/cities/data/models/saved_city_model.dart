import '../../domain/entities/saved_city.dart';

class SavedCityModel extends SavedCity {
  const SavedCityModel({
    required super.id,
    required super.name,
    required super.country,
    super.admin1,
    required super.latitude,
    required super.longitude,
    super.timezone,
    super.isCurrentLocation,
  });

  factory SavedCityModel.fromJson(Map<String, dynamic> json) {
    return SavedCityModel(
      id: json['id'] as String,
      name: json['name'] as String,
      country: json['country'] as String? ?? '',
      admin1: json['admin1'] as String?,
      latitude: (json['latitude'] as num).toDouble(),
      longitude: (json['longitude'] as num).toDouble(),
      timezone: json['timezone'] as String?,
      isCurrentLocation: json['isCurrentLocation'] as bool? ?? false,
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'country': country,
        'admin1': admin1,
        'latitude': latitude,
        'longitude': longitude,
        'timezone': timezone,
        'isCurrentLocation': isCurrentLocation,
      };

  factory SavedCityModel.fromSavedCity(SavedCity city) {
    return SavedCityModel(
      id: city.id,
      name: city.name,
      country: city.country,
      admin1: city.admin1,
      latitude: city.latitude,
      longitude: city.longitude,
      timezone: city.timezone,
      isCurrentLocation: city.isCurrentLocation,
    );
  }
}
