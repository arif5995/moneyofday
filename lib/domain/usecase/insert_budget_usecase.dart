import 'package:dartz/dartz.dart';
import 'package:monday/domain/entities/budget_entity.dart';
import 'package:monday/domain/repository/budget_repository.dart';
import 'package:monday/utils/error/failure_response.dart';
import 'package:monday/utils/usecase/use_case.dart';

class InsertBudgetUseCase extends UseCase<int, BudgetEntity>{
  final BudgetRepository budgetRepository;

  InsertBudgetUseCase({required this.budgetRepository});

  @override
  Future<Either<FailureResponse, int>> call(BudgetEntity params) async {
    return await budgetRepository.insertBudget(params);
  }

}