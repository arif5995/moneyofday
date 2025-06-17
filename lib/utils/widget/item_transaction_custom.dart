import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:monday/utils/gen/colors.gen.dart';
import 'package:monday/utils/widget/text_style.dart';

class ItemTransaction extends StatelessWidget {
  final SvgPicture asset;
  final String title;
  final String subtitle;
  final String price;
  final String clock;
  final Color colorPrice;
  final Color colorBackgroundIcon;
  final Function() onTap;

  const ItemTransaction(
      {super.key,
      required this.asset,
      required this.title,
      required this.subtitle,
      required this.price,
      required this.clock,
      required this.colorBackgroundIcon,
      required this.colorPrice,
      required this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      splashColor: ColorName.whitePurple,
      borderRadius: BorderRadius.circular(24.r),
      onTap: onTap,
      child: Ink(
        width: 336.w,
        height: 89.h,
        padding: const EdgeInsets.all(17),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(24.r),
            color: ColorName.greytipis),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              flex: 2,
              child: Container(
                width: 60.w,
                height: 60.w,
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16.r),
                    color: colorBackgroundIcon),
                child: asset,
              ),
            ),
            SizedBox(width: 10.w,),
            Expanded(
              flex: 3,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TextStyles.body2(text: title),
                  TextStyles.body4(text: subtitle, color: ColorName.textGrey)
                ],
              ),
            ),
            Expanded(
              flex: 5,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  TextStyles.body2(
                      text: price,
                      color: colorPrice,
                      fontWeight: FontWeight.bold),
                  TextStyles.body4(text: clock, color: ColorName.textGrey),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
