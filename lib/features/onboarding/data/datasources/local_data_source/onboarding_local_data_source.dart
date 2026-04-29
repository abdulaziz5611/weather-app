abstract class OnboardingLocalDataSource {
  Future<bool> isFirstRun();
  Future<void> completeOnboarding();
}
