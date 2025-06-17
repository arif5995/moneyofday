import 'package:monday/utils/navigation/navigation_helper.dart';
import 'package:monday/utils/navigation/router/app_router.dart';

abstract class AuthRouter {
  void navigateToSignIn();

  void navigateToSignUp();

  void goBack({String? arguments});

  void navigateToHome({int? index});

  void navigateToIntro();
}

class AuthRouterImpl implements AuthRouter {
  final NavigationHelper navigationHelper;

  AuthRouterImpl({required this.navigationHelper});

  @override
  void goBack({String? arguments}) {
    navigationHelper.pop(arguments);
  }

  @override
  void navigateToHome({int? index}) {
   navigationHelper.pushNamedAndRemoveUntil(AppRouter.home, arguments: index ?? 0);
  }

  @override
  void navigateToSignIn() {
    navigationHelper.pushNamedAndRemoveUntil(AppRouter.signIn);
  }

  @override
  void navigateToSignUp() {
    navigationHelper.pushNamedAndRemoveUntil(AppRouter.signUp);
  }

  @override
  void navigateToIntro() {
    navigationHelper.pushNamedAndRemoveUntil(AppRouter.intro);
  }
}
