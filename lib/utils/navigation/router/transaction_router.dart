import 'package:monday/domain/entities/transaction_entity.dart';
import 'package:monday/utils/navigation/navigation_helper.dart';
import 'package:monday/utils/navigation/router/app_router.dart';

abstract class TransactionRouter {
  void navigateToExpanse();

  void navigateToIncome();

  void navigateToTransfer();

  void navigateToDetailTransaction(TransactionEntity transactionEntity);
}

class TransactionRouterImpl implements TransactionRouter {
  final NavigationHelper navigationHelper;

  TransactionRouterImpl({required this.navigationHelper});

  @override
  void navigateToExpanse() {
    navigationHelper.pushReplacementNamed(AppRouter.expanse);
  }

  @override
  void navigateToIncome() {
    navigationHelper.pushReplacementNamed(AppRouter.income);
  }

  @override
  void navigateToTransfer() {
    navigationHelper.pushReplacementNamed(AppRouter.transfer);
  }

  @override
  void navigateToDetailTransaction(TransactionEntity transactionEntity) {
    navigationHelper.pushReplacementNamed(AppRouter.detailTransaction,
        arguments: transactionEntity);
  }
}
