import 'package:dartz/dartz.dart';
import 'package:monday/domain/repository/user_repository.dart';
import 'package:monday/utils/error/failure_response.dart';
import 'package:monday/utils/usecase/use_case.dart';

class CacheOnboardingUseCase extends UseCase<bool, NoParams>{
  final UserRepository userRepository;

  CacheOnboardingUseCase({required this.userRepository});

  @override
  Future<Either<FailureResponse, bool>> call(NoParams params) async {
    return await userRepository.cacheOnboarding();
  }

}