import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../repositories/onboarding_repository.dart';

class CheckFirstRun extends UseCase<bool, NoParams> {
  final OnboardingRepository repository;

  CheckFirstRun(this.repository);

  @override
  Future<Either<Failure, bool>> call(NoParams params) {
    return repository.isFirstRun();
  }
}
