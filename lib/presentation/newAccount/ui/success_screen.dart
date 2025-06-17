import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:monday/injections/injections.dart';
import 'package:monday/utils/gen/assets.gen.dart';
import 'package:monday/utils/gen/colors.gen.dart';
import 'package:monday/utils/navigation/router/auth_router.dart';
import 'package:monday/utils/widget/button_style.dart';
import 'package:monday/utils/widget/text_style.dart';

class SuccessScreen extends StatelessWidget {
  final AuthRouter authRouter = sl();
  SuccessScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: ColorName.whiteBackground,
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Assets.images.icons.success.svg(
                width: 128.w,
                height: 128.h
              ),
              SizedBox(height: 5.h,),
              TextStyles.body2(text: "You are set!"),
              SizedBox(height: 20.h,),
            ],
          )
        ),
      bottomSheet: Container(
        height: 100.h,
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
        color: Colors.white,
        child: ButtonStyles.ButtonNotIcon(
            backGroundColor: ColorName.purple,
            foreGroundColor: ColorName.whiteBackground,
            label: "Home",
            onTap: () {
              authRouter.navigateToHome();
            },),
      ),
    );
  }
}
