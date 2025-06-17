import 'package:dartz/dartz.dart';
import 'package:monday/domain/entities/category_transaction_entity.dart';
import 'package:monday/utils/error/failure_response.dart';

abstract class CategoryTransactionRepository{
  Future<Either<FailureResponse, List<CategoryTransactionEntity>>>getCategory();
  Future<Either<FailureResponse, int>>insertCategory(List<CategoryTransactionEntity> listCategory);
}