import 'package:dartz/dartz.dart';
import 'package:monday/domain/entities/budget_entity.dart';
import 'package:monday/utils/error/failure_response.dart';

abstract class BudgetRepository{
  Future<Either<FailureResponse, int>>insertBudget(BudgetEntity budgetEntity);
  Future<Either<FailureResponse, int>>updateBudget(BudgetEntity budgetEntity);
  Future<Either<FailureResponse, int>>deleteBudget(int id);
  Future<Either<FailureResponse, List<BudgetEntity>>>getDataBudget(int month);
}