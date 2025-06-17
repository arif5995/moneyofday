import 'package:dartz/dartz.dart';
import 'package:monday/datasource/local/database_impl.dart';
import 'package:monday/utils/error/failure_response.dart';

abstract class UserRepository {
    Future<Either<FailureResponse, List<UserData>>>getUser();
    Future<Either<FailureResponse, int>>insertUser(UserData userData);
    Future<Either<FailureResponse, bool>>cacheOnboarding();
    Future<Either<FailureResponse, bool>>getOnboarding();
}