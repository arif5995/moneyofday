import 'package:dartz/dartz.dart';
import 'package:monday/domain/entities/category_transaction_entity.dart';
import 'package:monday/domain/repository/category_transaction_repository.dart';
import 'package:monday/utils/error/failure_response.dart';
import 'package:monday/utils/usecase/use_case.dart';

class GetCategoryTransactionUseCase extends UseCase<List<CategoryTransactionEntity>, NoParams>{
  final CategoryTransactionRepository transactionRepository;

  GetCategoryTransactionUseCase({required this.transactionRepository});

  @override
  Future<Either<FailureResponse, List<CategoryTransactionEntity>>> call(NoParams params) async {
    return await transactionRepository.getCategory();
  }
}