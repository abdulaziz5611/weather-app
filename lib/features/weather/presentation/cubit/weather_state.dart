import 'package:equatable/equatable.dart';

import '../../domain/entities/air_quality.dart';
import '../../domain/entities/weather_forecast.dart';

sealed class WeatherState extends Equatable {
  const WeatherState();

  @override
  List<Object?> get props => [];
}

class WeatherInitial extends WeatherState {
  const WeatherInitial();
}

class WeatherLoading extends WeatherState {
  const WeatherLoading();
}

class WeatherLoaded extends WeatherState {
  final WeatherForecast forecast;
  final AirQuality? airQuality;

  const WeatherLoaded({required this.forecast, this.airQuality});

  @override
  List<Object?> get props => [forecast, airQuality];
}

class WeatherError extends WeatherState {
  final String message;

  const WeatherError(this.message);

  @override
  List<Object?> get props => [message];
}
