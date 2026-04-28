import 'package:equatable/equatable.dart';

import 'current_weather.dart';
import 'daily_forecast.dart';
import 'hourly_forecast.dart';

class WeatherForecast extends Equatable {
  final CurrentWeather current;
  final List<HourlyForecast> hourly;
  final List<DailyForecast> daily;
  final String timezone;

  const WeatherForecast({
    required this.current,
    required this.hourly,
    required this.daily,
    required this.timezone,
  });

  @override
  List<Object?> get props => [current, hourly, daily, timezone];
}
