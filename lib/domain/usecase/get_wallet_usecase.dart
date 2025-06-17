import 'package:dartz/dartz.dart';
import 'package:monday/datasource/model/wallet_bank_model.dart';
import 'package:monday/domain/repository/wallet_repository.dart';
import 'package:monday/utils/error/failure_response.dart';
import 'package:monday/utils/usecase/use_case.dart';

class GetWalletUseCase extends UseCase<List<WalletBankModel>, NoParams>{
  final WalletRepository walletRepository;

  GetWalletUseCase({required this.walletRepository});

  @override
  Future<Either<FailureResponse, List<WalletBankModel>>> call(NoParams params) async {
    return await walletRepository.getWallet();
  }

}