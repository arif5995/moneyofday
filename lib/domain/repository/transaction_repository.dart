import 'package:dartz/dartz.dart';
import 'package:monday/datasource/local/database_impl.dart';
import 'package:monday/domain/entities/transaction_entity.dart';
import 'package:monday/utils/error/failure_response.dart';

abstract class TransactionRepository {
  Future<Either<FailureResponse, int>> insertTransaction(
      TransactionsCompanion transactionsCompanion);

  Future<Either<FailureResponse, List<TransactionEntity>>> getAllTransaction(
      List<DateTime> date);

  Future<Either<FailureResponse, List<TransactionEntity>>>
      getTransactionByIdWallet(int idWallet);

  Future<Either<FailureResponse, List<TransactionEntity>>>
      getTransactionByIdCategoryAndMonth(int idCategory, int month);

  Future<Either<FailureResponse, List<TransactionEntity>>>
      getTransactionByTransactionTypeAndMonth(int idTransaction, int month);
}
