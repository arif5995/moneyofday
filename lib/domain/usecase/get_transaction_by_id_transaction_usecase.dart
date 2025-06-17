import 'package:dartz/dartz.dart';
import 'package:monday/domain/entities/transaction_entity.dart';
import 'package:monday/domain/repository/transaction_repository.dart';
import 'package:monday/utils/error/failure_response.dart';
import 'package:monday/utils/usecase/use_case.dart';

class GetTransactionByIdTransactionUseCase extends UseCase<List<TransactionEntity>, List<int>>{
  final TransactionRepository transactionRepository;

  GetTransactionByIdTransactionUseCase({required this.transactionRepository});

  @override
  Future<Either<FailureResponse, List<TransactionEntity>>> call(List<int> param) async {
    return await transactionRepository.getTransactionByTransactionTypeAndMonth(param[0], param[1]);
  }
}