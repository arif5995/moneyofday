import 'package:dartz/dartz.dart';
import 'package:monday/domain/entities/category_transaction_entity.dart';
import 'package:monday/domain/repository/category_transaction_repository.dart';
import 'package:monday/utils/error/failure_response.dart';
import 'package:monday/utils/usecase/use_case.dart';

class InsertCategoryTransactionUseCase extends UseCase<int, List<CategoryTransactionEntity>>{
  final CategoryTransactionRepository transactionRepository;

  InsertCategoryTransactionUseCase({required this.transactionRepository});

  @override
  Future<Either<FailureResponse, int>> call(List<CategoryTransactionEntity> params) async {
    return await transactionRepository.insertCategory(params);
  }
}