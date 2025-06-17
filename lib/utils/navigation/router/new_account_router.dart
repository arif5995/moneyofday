import 'package:monday/utils/navigation/navigation_helper.dart';
import 'package:monday/utils/navigation/router/app_router.dart';

abstract class NewAccountRouter{
  void navigateToNewAccount();
  void navigateToNewWallet();
  void navigateToSuccess();
}

class NewAccountRouterImpl implements NewAccountRouter{
  final NavigationHelper navigationHelper;

  NewAccountRouterImpl({required this.navigationHelper});
  @override
  void navigateToNewAccount() {
    navigationHelper.pushReplacementNamed(AppRouter.newAddAccount);
  }

  @override
  void navigateToNewWallet() {
    navigationHelper.pushReplacementNamed(AppRouter.newAddWallet);
  }

  @override
  void navigateToSuccess() {
    navigationHelper.pushNamedAndRemoveUntil(AppRouter.newAddSucces);
  }

}