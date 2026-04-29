import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/services/location_service.dart';
import '../../../../core/usecases/usecase.dart';
import '../../../cities/domain/entities/saved_city.dart';
import '../../domain/usecases/complete_onboarding.dart';
import 'onboarding_state.dart';

class OnboardingCubit extends Cubit<OnboardingState> {
  final LocationService locationService;
  final CompleteOnboarding completeOnboarding;

  OnboardingCubit({
    required this.locationService,
    required this.completeOnboarding,
  }) : super(const OnboardingIdle());

  Future<void> requestLocation() async {
    emit(const OnboardingRequestingLocation());
    final granted = await locationService.requestPermission();
    if (!granted) {
      emit(const OnboardingLocationDenied());
      return;
    }
    final location = await locationService.getCurrentLocation();
    if (location == null) {
      emit(const OnboardingError('Could not determine your location'));
      return;
    }
    final city = SavedCity(
      id: 'current-${location.latitude.toStringAsFixed(4)}_${location.longitude.toStringAsFixed(4)}',
      name: location.name,
      country: location.country,
      admin1: location.admin1,
      latitude: location.latitude,
      longitude: location.longitude,
      isCurrentLocation: true,
    );
    emit(OnboardingLocationReady(city));
  }

  Future<void> markComplete() async {
    await completeOnboarding(const NoParams());
  }
}
