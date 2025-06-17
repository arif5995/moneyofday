import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:monday/utils/gen/colors.gen.dart';
import 'package:monday/utils/widget/text_style.dart';

class DisplayFinancialCustom extends StatelessWidget {
  final Color background;
  final SvgPicture assets;
  final String title;
  final String price;

  const DisplayFinancialCustom(
      {super.key,
      required this.background,
      required this.assets,
      required this.title,
      required this.price});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 164.w,
      height: 85.h,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(28.r), color: background),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            width: 48.w,
            height: 48.w,
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16.r),
                color: ColorName.whiteBackground),
            child: assets,
          ),
          SizedBox(
            width: 10.w,
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextStyles.body2(text: title, color: Colors.white),
              TextStyles.header3(text: price, color: Colors.white, fontWeight: FontWeight.bold),
            ],
          )
        ],
      ),
    );
  }
}
