import 'package:equatable/equatable.dart';

import '../../../cities/domain/entities/saved_city.dart';

sealed class OnboardingState extends Equatable {
  const OnboardingState();

  @override
  List<Object?> get props => [];
}

class OnboardingIdle extends OnboardingState {
  const OnboardingIdle();
}

class OnboardingRequestingLocation extends OnboardingState {
  const OnboardingRequestingLocation();
}

class OnboardingLocationReady extends OnboardingState {
  final SavedCity city;
  const OnboardingLocationReady(this.city);

  @override
  List<Object?> get props => [city];
}

class OnboardingLocationDenied extends OnboardingState {
  const OnboardingLocationDenied();
}

class OnboardingError extends OnboardingState {
  final String message;
  const OnboardingError(this.message);

  @override
  List<Object?> get props => [message];
}
