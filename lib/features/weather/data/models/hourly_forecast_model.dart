import '../../domain/entities/hourly_forecast.dart';

class HourlyForecastModel extends HourlyForecast {
  const HourlyForecastModel({
    required super.time,
    required super.temperature,
    required super.condition,
    required super.precipitationProbability,
  });
}
