import '../../domain/entities/daily_forecast.dart';

class DailyForecastModel extends DailyForecast {
  const DailyForecastModel({
    required super.date,
    required super.temperatureMax,
    required super.temperatureMin,
    required super.condition,
    required super.precipitationSum,
    required super.sunrise,
    required super.sunset,
  });
}
