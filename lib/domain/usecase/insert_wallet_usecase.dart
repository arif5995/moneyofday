import 'package:dartz/dartz.dart';
import 'package:monday/datasource/local/database_impl.dart';
import 'package:monday/domain/repository/wallet_repository.dart';
import 'package:monday/utils/error/failure_response.dart';
import 'package:monday/utils/usecase/use_case.dart';

class InsertWalletUseCase extends UseCase<int, WalletCompanion>{
  final WalletRepository walletRepository;

  InsertWalletUseCase({required this.walletRepository});

  @override
  Future<Either<FailureResponse, int>> call(WalletCompanion params) async {
    return await walletRepository.insertNewWallet(params);
  }

}