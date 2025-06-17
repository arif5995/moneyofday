import 'package:dartz/dartz.dart';
import 'package:monday/domain/repository/budget_repository.dart';
import 'package:monday/utils/error/failure_response.dart';
import 'package:monday/utils/usecase/use_case.dart';

class DeleteBudgetUseCase extends UseCase<int, int>{
  final BudgetRepository budgetRepository;

  DeleteBudgetUseCase({required this.budgetRepository});

  @override
  Future<Either<FailureResponse, int>> call(int params) async {
    return await budgetRepository.deleteBudget(params);
  }

}