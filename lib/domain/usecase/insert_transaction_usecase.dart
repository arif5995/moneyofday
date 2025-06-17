import 'package:dartz/dartz.dart';
import 'package:monday/datasource/local/database_impl.dart';
import 'package:monday/domain/repository/transaction_repository.dart';
import 'package:monday/utils/error/failure_response.dart';
import 'package:monday/utils/usecase/use_case.dart';

class InsertTransactionUseCase extends UseCase<int, TransactionsCompanion>{
  final TransactionRepository transactionRepository;

  InsertTransactionUseCase({required this.transactionRepository});

  @override
  Future<Either<FailureResponse, int>> call(TransactionsCompanion params) async {
    return await transactionRepository.insertTransaction(params);
  }

}