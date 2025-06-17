import 'package:dartz/dartz.dart';
import 'package:monday/datasource/local/database_impl.dart';
import 'package:monday/datasource/model/wallet_bank_model.dart';
import 'package:monday/domain/repository/wallet_repository.dart';
import 'package:monday/utils/error/failure_response.dart';
import 'package:monday/utils/usecase/use_case.dart';

class GetWalletByMonthUseCase extends UseCase<List<WalletData>, int>{
  final WalletRepository walletRepository;

  GetWalletByMonthUseCase({required this.walletRepository});

  @override
  Future<Either<FailureResponse, List<WalletData>>> call(int params) async {
    return await walletRepository.getWalletByMonth(params);
  }

}