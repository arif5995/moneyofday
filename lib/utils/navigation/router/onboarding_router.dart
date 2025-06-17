import 'package:monday/utils/navigation/navigation_helper.dart';
import 'package:monday/utils/navigation/router/app_router.dart';

abstract class OnboardingRouter{
  void navigateToOnboarding();
}

class OnboardingRouterImpl implements OnboardingRouter{
  final NavigationHelper navigationHelper;

  OnboardingRouterImpl({required this.navigationHelper});
  @override
  void navigateToOnboarding() {
    navigationHelper.pushReplacementNamed(AppRouter.onboarding);
  }

}