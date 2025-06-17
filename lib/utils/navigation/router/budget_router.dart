import 'package:monday/domain/entities/budget_entity.dart';
import 'package:monday/utils/navigation/navigation_helper.dart';
import 'package:monday/utils/navigation/router/app_router.dart';

abstract class BudgetRouter {
  void navigateToCreateBudget();
  void navigateToEditBudget(BudgetEntity budgetEntity);
  void navigateToDetailBudget(BudgetEntity budgetEntity);
  void navigationToBack();
}

class BudgetRouterImpl implements BudgetRouter{
  final NavigationHelper navigationHelper;

  BudgetRouterImpl({required this.navigationHelper});

  @override
  void navigateToCreateBudget() {
    navigationHelper.pushReplacementNamed(AppRouter.createBudget);
  }

  @override
  void navigateToDetailBudget(BudgetEntity budgetEntity) {
    navigationHelper.pushReplacementNamed(AppRouter.detailBudget, arguments: budgetEntity);
  }

  @override
  void navigationToBack() {
    navigationHelper.pop();
  }

  @override
  void navigateToEditBudget(BudgetEntity budgetEntity) {
    navigationHelper.pushReplacementNamed(AppRouter.editBudget, arguments: budgetEntity);
  }

}