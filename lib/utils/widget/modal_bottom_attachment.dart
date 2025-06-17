import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:monday/utils/gen/assets.gen.dart';
import 'package:monday/utils/gen/colors.gen.dart';
import 'package:monday/utils/widget/text_style.dart';

class ModalBottom {
  static void modalBottomSheetAttachment(
      {required BuildContext context,
      required Function() onTapCamera,
      required Function() onTapImage,
      required Function() onTapDocument}) {
    showModalBottomSheet<void>(
      context: context,
      builder: (BuildContext context) {
        return SizedBox(
            height: 205.h,
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: 36.w,
                    height: 4.h,
                    color: ColorName.whitePurple,
                  ),
                  SizedBox(
                    height: 48.h,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      InkWell(
                        borderRadius: BorderRadius.circular(16.r),
                        onTap: onTapCamera,
                        child: Ink(
                          width: 107.w,
                          height: 91.h,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(16.r),
                              color: ColorName.whitePurple),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Assets.images.icons.camera.svg(
                                  color: ColorName.purple,
                                  width: 28.w,
                                  height: 24.h),
                              SizedBox(
                                height: 8.h,
                              ),
                              TextStyles.body3(
                                  text: "Camera", color: ColorName.purple)
                            ],
                          ),
                        ),
                      ),
                      InkWell(
                        borderRadius: BorderRadius.circular(16.r),
                        onTap: onTapImage,
                        child: Ink(
                          width: 107.w,
                          height: 91.h,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(16.r),
                              color: ColorName.whitePurple),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Assets.images.icons.gallery.svg(
                                  color: ColorName.purple,
                                  width: 28.w,
                                  height: 24.h),
                              SizedBox(
                                height: 8.h,
                              ),
                              TextStyles.body3(
                                  text: "Image", color: ColorName.purple)
                            ],
                          ),
                        ),
                      ),
                      InkWell(
                        borderRadius: BorderRadius.circular(16.r),
                        onTap: onTapDocument,
                        child: Ink(
                          width: 107.w,
                          height: 91.h,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(16.r),
                              color: ColorName.whitePurple),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Assets.images.icons.file.svg(
                                  color: ColorName.purple,
                                  width: 28.w,
                                  height: 24.h),
                              SizedBox(
                                height: 8.h,
                              ),
                              TextStyles.body3(
                                  text: "Document", color: ColorName.purple)
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                ],
              ),
            ));
      },
    );
  }
}
