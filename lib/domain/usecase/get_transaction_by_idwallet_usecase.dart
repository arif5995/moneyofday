import 'package:dartz/dartz.dart';
import 'package:monday/domain/entities/transaction_entity.dart';
import 'package:monday/domain/repository/transaction_repository.dart';
import 'package:monday/utils/error/failure_response.dart';
import 'package:monday/utils/usecase/use_case.dart';

class GetTransactionByIdWalletUseCase extends UseCase<List<TransactionEntity>, int>{
  final TransactionRepository transactionRepository;

  GetTransactionByIdWalletUseCase({required this.transactionRepository});

  @override
  Future<Either<FailureResponse, List<TransactionEntity>>> call(int idWallet) async {
    return await transactionRepository.getTransactionByIdWallet(idWallet);
  }
}