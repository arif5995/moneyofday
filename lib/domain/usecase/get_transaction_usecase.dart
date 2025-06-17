import 'package:dartz/dartz.dart';
import 'package:monday/domain/entities/transaction_entity.dart';
import 'package:monday/domain/repository/transaction_repository.dart';
import 'package:monday/utils/error/failure_response.dart';
import 'package:monday/utils/usecase/use_case.dart';

class GetTransactionUseCase extends UseCase<List<TransactionEntity>, List<DateTime>>{
  final TransactionRepository transactionRepository;

  GetTransactionUseCase({required this.transactionRepository});

  @override
  Future<Either<FailureResponse, List<TransactionEntity>>> call(List<DateTime> params) async {
    return await transactionRepository.getAllTransaction(params);
  }

}