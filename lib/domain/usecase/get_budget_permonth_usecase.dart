import 'package:dartz/dartz.dart';
import 'package:monday/domain/entities/budget_entity.dart';
import 'package:monday/domain/repository/budget_repository.dart';
import 'package:monday/utils/error/failure_response.dart';
import 'package:monday/utils/usecase/use_case.dart';

class GetBudgetPerMonthUseCase extends UseCase<List<BudgetEntity>, int>{
  final BudgetRepository budgetRepository;

  GetBudgetPerMonthUseCase({required this.budgetRepository});

  @override
  Future<Either<FailureResponse, List<BudgetEntity>>> call(int month) async {
    return await budgetRepository.getDataBudget(month);
  }
}