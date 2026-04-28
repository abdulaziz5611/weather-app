import 'package:equatable/equatable.dart';

import '../../../../core/types/weather_condition.dart';

class CurrentWeather extends Equatable {
  final double temperature;
  final double feelsLike;
  final WeatherCondition condition;
  final bool isDay;
  final int humidity;
  final double windSpeed;
  final int windDirection;
  final double pressure;
  final double precipitation;
  final DateTime time;

  const CurrentWeather({
    required this.temperature,
    required this.feelsLike,
    required this.condition,
    required this.isDay,
    required this.humidity,
    required this.windSpeed,
    required this.windDirection,
    required this.pressure,
    required this.precipitation,
    required this.time,
  });

  @override
  List<Object?> get props => [
        temperature,
        feelsLike,
        condition,
        isDay,
        humidity,
        windSpeed,
        windDirection,
        pressure,
        precipitation,
        time,
      ];
}
