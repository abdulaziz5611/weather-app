import '../../domain/entities/air_quality.dart';

class AirQualityModel extends AirQuality {
  const AirQualityModel({
    required super.aqi,
    required super.pm25,
    required super.pm10,
    required super.ozone,
    required super.nitrogenDioxide,
  });

  factory AirQualityModel.fromJson(Map<String, dynamic> json) {
    final current = json['current'] as Map<String, dynamic>;
    return AirQualityModel(
      aqi: ((current['european_aqi'] as num?) ?? 0).toInt(),
      pm25: ((current['pm2_5'] as num?) ?? 0).toDouble(),
      pm10: ((current['pm10'] as num?) ?? 0).toDouble(),
      ozone: ((current['ozone'] as num?) ?? 0).toDouble(),
      nitrogenDioxide: ((current['nitrogen_dioxide'] as num?) ?? 0).toDouble(),
    );
  }
}
