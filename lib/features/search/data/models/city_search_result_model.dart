import '../../domain/entities/city_search_result.dart';

class CitySearchResultModel extends CitySearchResult {
  const CitySearchResultModel({
    required super.id,
    required super.name,
    required super.country,
    super.admin1,
    required super.latitude,
    required super.longitude,
    super.timezone,
  });

  factory CitySearchResultModel.fromJson(Map<String, dynamic> json) {
    return CitySearchResultModel(
      id: (json['id'] as num).toInt(),
      name: json['name'] as String,
      country: json['country'] as String? ?? '',
      admin1: json['admin1'] as String?,
      latitude: (json['latitude'] as num).toDouble(),
      longitude: (json['longitude'] as num).toDouble(),
      timezone: json['timezone'] as String?,
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
      };
}
