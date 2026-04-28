import 'package:equatable/equatable.dart';

import '../../../../core/types/weather_condition.dart';

class DailyForecast extends Equatable {
  final DateTime date;
  final double temperatureMax;
  final double temperatureMin;
  final WeatherCondition condition;
  final double precipitationSum;
  final DateTime sunrise;
  final DateTime sunset;

  const DailyForecast({
    required this.date,
    required this.temperatureMax,
    required this.temperatureMin,
    required this.condition,
    required this.precipitationSum,
    required this.sunrise,
    required this.sunset,
  });

  @override
  List<Object?> get props => [
        date,
        temperatureMax,
        temperatureMin,
        condition,
        precipitationSum,
        sunrise,
        sunset,
      ];
}
