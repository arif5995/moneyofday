import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:monday/utils/gen/colors.gen.dart';
import 'package:monday/utils/widget/text_style.dart';

class ItemWallet extends StatelessWidget {
  final Function() onTap;
  final String name;
  final String price;
  final SvgPicture svg;
  const ItemWallet({super.key, required this.onTap, required this.name, required this.price, required this.svg});


  @override
  Widget build(BuildContext context) {
    return InkWell(
      splashColor: ColorName.greytipis,
      onTap: onTap,
      child: SizedBox(
        height: 80.h,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              flex: 10,
              child: Container(
                height: 48.h,
                padding: EdgeInsets.all(16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      height: 48.h,
                      width: 48.w,
                      padding: const EdgeInsets.all(7),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(16.r),
                          color: ColorName.grey),
                      child: svg,
                    ),
                    SizedBox(width: 8.w,),
                    Expanded(
                      flex: 9,
                      child: Align(
                          alignment: Alignment.centerLeft,
                          child: TextStyles.header3(text: name,color: Colors.black, fontWeight: FontWeight.bold)),
                    ),
                    Expanded(
                      flex: 8,
                      child: Align(
                          alignment: Alignment.centerRight,
                          child: TextStyles.header3(text: price, color: Colors.black, fontWeight: FontWeight.bold)),
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
              flex: 1,
              child: Divider(
                thickness: 1,
              ),
            )
          ],
        ),
      ),
    );
  }
}
