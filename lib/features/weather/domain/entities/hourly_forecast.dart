import 'package:equatable/equatable.dart';

import '../../../../core/types/weather_condition.dart';

class HourlyForecast extends Equatable {
  final DateTime time;
  final double temperature;
  final WeatherCondition condition;
  final int precipitationProbability;

  const HourlyForecast({
    required this.time,
    required this.temperature,
    required this.condition,
    required this.precipitationProbability,
  });

  @override
  List<Object?> get props => [time, temperature, condition, precipitationProbability];
}
