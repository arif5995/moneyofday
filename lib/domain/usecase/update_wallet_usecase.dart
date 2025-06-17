import 'package:dartz/dartz.dart';
import 'package:monday/datasource/local/database_impl.dart';
import 'package:monday/domain/repository/wallet_repository.dart';
import 'package:monday/utils/error/failure_response.dart';
import 'package:monday/utils/usecase/use_case.dart';

class UpdateWalletUseCase extends UseCase<int, WalletData>{
  final WalletRepository walletRepository;

  UpdateWalletUseCase({required this.walletRepository});

  @override
  Future<Either<FailureResponse, int>> call(WalletData params) async {
    return await walletRepository.transferWallet(params);
  }

}