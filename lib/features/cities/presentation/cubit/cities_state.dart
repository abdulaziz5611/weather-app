import 'package:equatable/equatable.dart';

import '../../../weather/domain/entities/current_weather.dart';
import '../../domain/entities/saved_city.dart';

sealed class CitiesState extends Equatable {
  const CitiesState();

  @override
  List<Object?> get props => [];
}

class CitiesInitial extends CitiesState {
  const CitiesInitial();
}

class CitiesLoading extends CitiesState {
  const CitiesLoading();
}

class CitiesLoaded extends CitiesState {
  final List<SavedCity> cities;
  final Map<String, CurrentWeather> weather;

  const CitiesLoaded({required this.cities, this.weather = const {}});

  @override
  List<Object?> get props => [cities, weather];
}

class CitiesError extends CitiesState {
  final String message;
  const CitiesError(this.message);

  @override
  List<Object?> get props => [message];
}
