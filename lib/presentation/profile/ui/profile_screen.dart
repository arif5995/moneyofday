import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:monday/domain/entities/user_entity.dart';
import 'package:monday/injections/injections.dart';
import 'package:monday/utils/gen/assets.gen.dart';
import 'package:monday/utils/gen/colors.gen.dart';
import 'package:monday/utils/navigation/router/profile_router.dart';
import 'package:monday/utils/widget/text_style.dart';

class ProfileScreen extends StatelessWidget {
  final ProfileRouter profileRouter = sl();

  ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorName.grey,
      body: Column(
        children: [
          SizedBox(height: 74.h),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.all(Radius.circular(50.r)),
                  child: Container(
                    width: 80.w,
                    height: 80.w,
                    color: ColorName.purple,
                    child: FadeInImage(
                        image: AssetImage(Assets.images.picture.penguin.path),
                        placeholder:
                            AssetImage(Assets.images.picture.penguin.path),
                        fit: BoxFit.cover,
                        placeholderFit: BoxFit.cover,
                        alignment: Alignment.center,
                        fadeInDuration: const Duration(milliseconds: 100),
                        imageErrorBuilder: (context, error, stackTrace) {
                          if (error is Exception) {
                            return const SizedBox();
                          }
                          return const SizedBox();
                        }),
                  ),
                ),
                SizedBox(
                  width: 19.w,
                ),
                Expanded(
                  child: SizedBox(
                    height: 54.h,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        TextStyles.body3(
                            text: "Username", color: ColorName.textGrey),
                        TextStyles.header3(
                            text: "Carl Johnson", color: Colors.black)
                      ],
                    ),
                  ),
                ),
                InkWell(
                  borderRadius: BorderRadius.circular(8.r),
                  splashColor: Colors.grey,
                  onTap: () {
                    profileRouter.navigateToEditProfile(
                        UserEntity(id: 1, name: "Muhammad Arif", photo: ""));
                  },
                  child: Ink(
                    width: 40.w,
                    height: 40.h,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8.r),
                        border: Border.all(
                            color: ColorName.whitePurple,
                            style: BorderStyle.solid,
                            width: 0.80)),
                    child: Center(
                        child: Assets.images.icons.edit
                            .svg(width: 32.w, height: 32.h)),
                  ),
                )
              ],
            ),
          ),
          SizedBox(
            height: 40.h,
          ),
          InkWell(
            borderRadius: BorderRadius.only(
                topRight: Radius.circular(24.r),
                topLeft: Radius.circular(24.r)),
            splashColor: ColorName.greytipis,
            onTap: () {
              profileRouter.navigateToAccount();
            },
            child: Ink(
              width: 336.w,
              height: 89.h,
              padding: const EdgeInsets.symmetric(horizontal: 17, vertical: 18),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                      topRight: Radius.circular(24.r),
                      topLeft: Radius.circular(24.r)),
                  color: ColorName.whiteBackground),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    width: 52.w,
                    height: 53.h,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(16.r),
                        color: ColorName.whitePurple),
                    child: Center(
                      child: Assets.images.icons.wallet.svg(),
                    ),
                  ),
                  SizedBox(
                    width: 9.w,
                  ),
                  TextStyles.body2(text: "Account")
                ],
              ),
            ),
          ),
          SizedBox(
            height: 1.h,
          ),
          InkWell(
            splashColor: ColorName.greytipis,
            borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(24.r),
                bottomRight: Radius.circular(24.r)),
            onTap: () {},
            child: Ink(
              width: 336.w,
              height: 89.h,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(24.r),
                      bottomRight: Radius.circular(24.r)),
                  color: ColorName.whiteBackground),
              padding: const EdgeInsets.symmetric(horizontal: 17, vertical: 18),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    width: 52.w,
                    height: 53.h,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(16.r),
                        color: ColorName.whitePurple),
                    child: Center(
                      child: Assets.images.icons.settings.svg(),
                    ),
                  ),
                  SizedBox(
                    width: 9.w,
                  ),
                  TextStyles.body2(text: "Setting")
                ],
              ),
            ),
          ),
          SizedBox(
            height: 1.h,
          ),
          // InkWell(
          //   borderRadius: BorderRadius.only(
          //       bottomLeft: Radius.circular(24.r),
          //       bottomRight: Radius.circular(24.r)),
          //   splashColor: ColorName.greytipis,
          //   onTap: () {},
          //   child: Ink(
          //     width: 336.w,
          //     height: 89.h,
          //     padding: const EdgeInsets.symmetric(horizontal: 17, vertical: 18),
          //     decoration: BoxDecoration(
          //         borderRadius: BorderRadius.only(
          //             bottomLeft: Radius.circular(24.r),
          //             bottomRight: Radius.circular(24.r)),
          //         color: ColorName.whiteBackground),
          //     child: Row(
          //       mainAxisAlignment: MainAxisAlignment.start,
          //       crossAxisAlignment: CrossAxisAlignment.center,
          //       children: [
          //         Container(
          //           width: 52.w,
          //           height: 53.h,
          //           decoration: BoxDecoration(
          //               borderRadius: BorderRadius.circular(16.r),
          //               color: ColorName.bacgroundRedIcon),
          //           child: Center(
          //             child: Assets.images.icons.logout.svg(),
          //           ),
          //         ),
          //         SizedBox(
          //           width: 9.w,
          //         ),
          //         TextStyles.body2(text: "Logout")
          //       ],
          //     ),
          //   ),
          // ),
        ],
      ),
    );
  }
}
