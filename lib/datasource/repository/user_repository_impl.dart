import 'package:dartz/dartz.dart';
import 'package:monday/datasource/local/database_impl.dart';
import 'package:monday/domain/repository/user_repository.dart';
import 'package:monday/utils/constant/app_constant.dart';
import 'package:monday/utils/error/failure_response.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserRepositoryImpl implements UserRepository {
  final DatabaseImpl databaseImpl;
  final SharedPreferences sharedPreferences;

  UserRepositoryImpl({
    required this.databaseImpl,
    required this.sharedPreferences
  });

  @override
  Future<Either<FailureResponse, int>> insertUser(UserData userData) async{
    final result = await databaseImpl.into(databaseImpl.user).insert(userData);
    if (result != 0) {
      return Right(result);
    } else {
      return const Left(
          FailureResponse(errorMessage: "Gagal Insert", statusCode: 0));
    }
  }

  @override
  Future<Either<FailureResponse, List<UserData>>> getUser() async {
    try {
      final result = await databaseImpl.select(databaseImpl.user).get();
      return Right(result);
    }catch(e){
      return const Left(
          FailureResponse(errorMessage: "Terjadi kesalahan", statusCode: 0));
    }
  }

  @override
  Future<Either<FailureResponse, bool>> cacheOnboarding() async {
    final result = await sharedPreferences.setBool(AppConstants.cachedKey.onBoardingKey, true);
    return Right(result);
  }

  @override
  Future<Either<FailureResponse, bool>> getOnboarding()async {
    try {
      final result = sharedPreferences.getBool(AppConstants.cachedKey.onBoardingKey) ??
          false;
      return Right(result);
    } catch (_) {
      return const Left(FailureResponse(errorMessage: "Gagal get onboarding"));
    }
  }
}
