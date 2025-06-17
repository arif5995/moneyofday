import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ionicons/ionicons.dart';
import 'package:monday/domain/entities/budget_entity.dart';
import 'package:monday/utils/currency/currency_format.dart';
import 'package:monday/utils/gen/colors.gen.dart';
import 'package:monday/utils/widget/text_style.dart';
import 'package:percent_indicator/percent_indicator.dart';

class ItemBudget extends StatelessWidget {
  final BudgetEntity budgetEntity;
  final Function() onTap;

  const ItemBudget(
      {super.key, required this.budgetEntity, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  padding: EdgeInsets.all(8),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(32.r),
                      color: ColorName.lightGrey),
                  child: Row(
                    children: [
                      ClipOval(
                        child: Container(
                            height: 14,
                            width: 14,
                            color: budgetEntity.circleCategory),
                      ),
                      SizedBox(
                        width: 10.w,
                      ),
                      TextStyles.body4(text: budgetEntity.categoryName ?? "")
                    ],
                  ),
                ),
                budgetEntity.exceedLimit
                    ? Icon(
                        Ionicons.alert_circle,
                        color: Colors.red,
                        size: 25.sp,
                      )
                    : const SizedBox()
              ],
            ),
            SizedBox(
              height: 10.h,
            ),
            TextStyles.header2(
                text:
                    "Remaining ${CurrencyFormat.convertToIdr(budgetEntity.totalRemain, 0)}",
                color: Colors.black),
            SizedBox(
              height: 10.h,
            ),
            LinearPercentIndicator(
              padding: EdgeInsets.all(0),
              animation: true,
              lineHeight: 20.0,
              animationDuration: 2500,
              percent: budgetEntity.totalPersentase,
              center: Text("${budgetEntity.textPersent}%"),
              barRadius: Radius.circular(20.r),
              progressColor: Colors.green,
            ),
            SizedBox(
              height: 5.h,
            ),
            TextStyles.body2(
                text:
                    "${CurrencyFormat.convertToIdr(int.parse(budgetEntity.price), 0)} of ${CurrencyFormat.convertToIdr(int.parse(budgetEntity.priceCategory ?? "0"), 0)}",
                color: Colors.grey),
            SizedBox(
              height: 5.h,
            ),
            budgetEntity.exceedLimit
                ? TextStyles.body3(
                    text: "You’ve exceed the limit!", color: Colors.red)
                : const SizedBox()
          ],
        ),
      ),
    );
  }
}
