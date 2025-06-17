import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:introduction_screen/introduction_screen.dart';
import 'package:monday/injections/injections.dart';
import 'package:monday/utils/gen/assets.gen.dart';
import 'package:monday/utils/gen/colors.gen.dart';
import 'package:monday/utils/navigation/router/auth_router.dart';

class OnboardingScreen extends StatelessWidget {
  OnboardingScreen({super.key});
  final AuthRouter _authRouter = sl();

  @override
  Widget build(BuildContext context) {
    return IntroductionScreen(
      globalBackgroundColor: ColorName.whiteBackground,
      pages: [
        PageViewModel(
          image: Image.asset(
            Assets.images.onboarding.onBoarding1.path,
            width: 205.w,
            height: 205.h,
          ),
          title: "Gaint total control of your money",
          body: "Become your own money manager\n and make every cent count ",
          decoration: PageDecoration(
            imageFlex: 2,
            titlePadding: const EdgeInsets.only(bottom: 10.0, top: 64.0),
            contentMargin: const EdgeInsets.symmetric(horizontal: 64.0),
            titleTextStyle: TextStyle(
              color: ColorName.textBlack,
              fontSize: 25.sp,
              fontWeight: FontWeight.bold,
            ),
            bodyTextStyle: TextStyle(
              color: ColorName.textGrey,
              fontSize: 14.sp,
              fontWeight: FontWeight.w400,
            ),
          ),
        ),
        PageViewModel(
          image: Image.asset(
            Assets.images.onboarding.onBoarding2.path,
            width: 205.w,
            height: 205.h,
          ),
          title: "Know where your\n money goes",
          body: "Track your transaction easily,\n with category and financial report",
          decoration: PageDecoration(
            imageFlex: 2,
            titlePadding: const EdgeInsets.only(bottom: 10.0, top: 64.0),
            contentMargin: const EdgeInsets.symmetric(horizontal: 64.0),
            titleTextStyle: TextStyle(
              color: ColorName.textBlack,
              fontSize: 25.sp,
              fontWeight: FontWeight.bold,
            ),
            bodyTextStyle: TextStyle(
              color: ColorName.textGrey,
              fontSize: 14.sp,
              fontWeight: FontWeight.w400,
            ),
          ),
        ),
        PageViewModel(
          image: Image.asset(
            Assets.images.onboarding.onBoarding3.path,
            width: 205.w,
            height: 205.h,
          ),
          title: "Planning ahead",
          body: "Setup your budget for each category\n  so you in control",
          decoration: PageDecoration(
            imageFlex: 2,
            titlePadding: const EdgeInsets.only(bottom: 10.0, top: 64.0),
            contentMargin: const EdgeInsets.symmetric(horizontal: 64.0),
            titleTextStyle: TextStyle(
              color: ColorName.textBlack,
              fontSize: 25.sp,
              fontWeight: FontWeight.bold,
            ),
            bodyTextStyle: TextStyle(
              color: ColorName.textGrey,
              fontSize: 14.sp,
              fontWeight: FontWeight.w400,
            ),
          ),
        ),
      ],
      onDone: ()=>_authRouter.navigateToIntro(),
      showBackButton: false,
      showNextButton: false,
      showSkipButton: true,
      dotsDecorator: const DotsDecorator(
        size: Size(10.0, 10.0),
        color: ColorName.textGrey,
        activeColor: ColorName.purple,
        activeSize: Size(22.0, 10.0),
        activeShape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(25.0)),
        ),
      ),
      skip: Text(
        "Lewati",
        style: TextStyle(
          color:ColorName.purple,
          fontSize: 14.sp,
          fontWeight: FontWeight.w100,
        ),
      ),
      done: Text(
        "Selesai",
        style: TextStyle(
          color: ColorName.purple,
          fontSize: 14.sp,
          fontWeight: FontWeight.w100,
        ),
      ),
    );
  }
}
