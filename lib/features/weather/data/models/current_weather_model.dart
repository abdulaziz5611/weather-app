import '../../../../core/types/weather_condition.dart';
import '../../domain/entities/current_weather.dart';

class CurrentWeatherModel extends CurrentWeather {
  const CurrentWeatherModel({
    required super.temperature,
    required super.feelsLike,
    required super.condition,
    required super.isDay,
    required super.humidity,
    required super.windSpeed,
    required super.windDirection,
    required super.pressure,
    required super.precipitation,
    required super.time,
  });

  factory CurrentWeatherModel.fromJson(Map<String, dynamic> json) {
    final code = (json['weather_code'] as num).toInt();
    final isDay = (json['is_day'] as num).toInt() == 1;
    return CurrentWeatherModel(
      temperature: (json['temperature_2m'] as num).toDouble(),
      feelsLike: (json['apparent_temperature'] as num).toDouble(),
      condition: WeatherConditionMapper.fromWmoCode(code, isDay: isDay),
      isDay: isDay,
      humidity: (json['relative_humidity_2m'] as num).toInt(),
      windSpeed: (json['wind_speed_10m'] as num).toDouble(),
      windDirection: (json['wind_direction_10m'] as num).toInt(),
      pressure: (json['pressure_msl'] as num).toDouble(),
      precipitation: (json['precipitation'] as num).toDouble(),
      time: DateTime.parse(json['time'] as String),
    );
  }
}
