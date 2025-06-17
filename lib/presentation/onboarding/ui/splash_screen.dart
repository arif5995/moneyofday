import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:monday/injections/injections.dart';
import 'package:monday/presentation/onboarding/bloc/splash_bloc/splash_cubit.dart';
import 'package:monday/utils/gen/colors.gen.dart';
import 'package:monday/utils/navigation/router/auth_router.dart';
import 'package:monday/utils/navigation/router/onboarding_router.dart';
import 'package:monday/utils/state/view_data_state.dart';

class SplashScreen extends StatelessWidget {
  final OnboardingRouter onboardingRouter = sl();
  final AuthRouter authRouter = sl();

  SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorName.purple,
      body: MultiBlocListener(
        listeners: [
          BlocListener<SplashCubit, SplashState>(
            listener: (context, state) {
              final status = state.splashState.status;
              final statusCategory = state.category.status;
              if (status.isHasData) {
                if (state.splashState.data!) {
                  authRouter.navigateToHome();
                }
              }
              if (status.isNoData) {
                onboardingRouter.navigateToOnboarding();
              }

            },
          ),
        ],
        child: SizedBox(
          width: 1.sw,
          height: 1.sh,
          child: Center(
              child: Image.asset("assets/images/picture/m.png"),
          ),
        ),
      ),
    );
  }
}
