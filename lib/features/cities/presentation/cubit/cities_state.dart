import 'package:equatable/equatable.dart';

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
  const CitiesLoaded(this.cities);

  @override
  List<Object?> get props => [cities];
}

class CitiesError extends CitiesState {
  final String message;
  const CitiesError(this.message);

  @override
  List<Object?> get props => [message];
}
