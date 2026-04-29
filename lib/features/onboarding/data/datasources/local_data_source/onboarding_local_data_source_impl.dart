import 'package:hive/hive.dart';

import '../../../../../core/constants/app_constants.dart';
import 'onboarding_local_data_source.dart';

class OnboardingLocalDataSourceImpl implements OnboardingLocalDataSource {
  final Box<bool> box;

  OnboardingLocalDataSourceImpl(this.box);

  @override
  Future<bool> isFirstRun() async {
    final completed = box.get(AppConstants.onboardingCompletedKey, defaultValue: false);
    return !(completed ?? false);
  }

  @override
  Future<void> completeOnboarding() async {
    await box.put(AppConstants.onboardingCompletedKey, true);
  }
}
