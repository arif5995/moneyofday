import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ionicons/ionicons.dart';
import 'package:monday/domain/entities/budget_entity.dart';
import 'package:monday/injections/injections.dart';
import 'package:monday/presentation/budget/bloc/budget_cubit.dart';
import 'package:monday/utils/gen/colors.gen.dart';
import 'package:monday/utils/navigation/router/auth_router.dart';
import 'package:monday/utils/navigation/router/budget_router.dart';
import 'package:monday/utils/state/view_data_state.dart';
import 'package:monday/utils/widget/button_style.dart';
import 'package:monday/utils/widget/text_style.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';

class DetailBudgetScreen extends StatelessWidget {
  final BudgetEntity budgetEntity;
  final BudgetRouter budgetRouter = sl();
  final AuthRouter authRouter = sl();

  DetailBudgetScreen({super.key, required this.budgetEntity});

  @override
  Widget build(BuildContext context) {
    return BlocListener<BudgetCubit, BudgetState>(
      listener: (context, state) {
        final statusDelete = state.deleteBudget.status;
        if (statusDelete.isHasData) {
          showTopSnackBar(
            Overlay.of(context),
            const CustomSnackBar.success(
              message: "Success delete budget",
            ),
          );
          authRouter.navigateToHome(index: 2);
        } else if (statusDelete.isNoData) {
          showTopSnackBar(
            Overlay.of(context),
            const CustomSnackBar.error(
              message: "Failed delete budget",
            ),
          );
        }
      },
      child: Scaffold(
        backgroundColor: ColorName.whiteBackground,
        appBar: AppBar(
          backgroundColor: ColorName.whiteBackground,
          leading: IconButton(
            onPressed: () {
              authRouter.navigateToHome(index: 2);
            },
            icon: Icon(
              Icons.arrow_back,
              color: Colors.black,
              size: 25.sp,
            ),
          ),
          title: TextStyles.body2(
              text: "Detail Budget", fontWeight: FontWeight.bold),
          actions: [
            IconButton(
              onPressed: () {
                showModalBottomSheet<void>(
                  context: context,
                  builder: (BuildContext ctx) {
                    return Container(
                      padding: EdgeInsets.all(16),
                      height: 217.h,
                      child: Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          mainAxisSize: MainAxisSize.max,
                          children: <Widget>[
                            TextStyles.header3(
                                text: "Remove this widget?",
                                color: Colors.black,
                                fontWeight: FontWeight.bold),
                            SizedBox(
                              height: 15.h,
                            ),
                            TextStyles.body2(
                              text:
                                  "Are you sure do you wanna\n remove this budget?",
                              color: Colors.black,
                            ),
                            SizedBox(
                              height: 20.h,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              mainAxisSize: MainAxisSize.max,
                              children: [
                                SizedBox(
                                  width: 164.w,
                                  height: 56.h,
                                  child: ButtonStyles.ButtonNotIcon(
                                    backGroundColor: ColorName.whitePurple,
                                    foreGroundColor: Colors.grey,
                                    label: "No",
                                    colorText: ColorName.purple,
                                    onTap: () {
                                      Navigator.pop(context);
                                    },
                                  ),
                                ),
                                SizedBox(
                                  width: 164.w,
                                  height: 56.h,
                                  child: ButtonStyles.ButtonNotIcon(
                                    backGroundColor: ColorName.purple,
                                    foreGroundColor: Colors.grey,
                                    label: "Yes",
                                    colorText: ColorName.whitePurple,
                                    onTap: () {
                                      context
                                          .read<BudgetCubit>()
                                          .deleteBudget(idBudget: budgetEntity.id ?? 0);
                                    },
                                  ),
                                ),
                              ],
                            ),
                            // ElevatedButton(
                            //   child: const Text('Close BottomSheet'),
                            //   onPressed: () => Navigator.pop(context),
                            // ),
                          ],
                        ),
                      ),
                    );
                  },
                );
              },
              icon: Icon(
                Ionicons.trash,
                size: 24.sp,
              ),
            )
          ],
        ),
        body: SafeArea(
            child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.max,
            children: [
              SizedBox(
                height: 38.h,
              ),
              Container(
                padding: EdgeInsets.all(16),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(24.r),
                    border: Border.all(color: Colors.grey)),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      width: 32.w,
                      height: 32.h,
                      padding: const EdgeInsets.all(4),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8.r),
                          color: budgetEntity.backgroundColor),
                      child: budgetEntity.iconAsset,
                    ),
                    SizedBox(
                      width: 8.w,
                    ),
                    TextStyles.header3(
                        text: budgetEntity.categoryName ?? "",
                        color: Colors.black),
                  ],
                ),
              ),
              SizedBox(
                height: 32.h,
              ),
              TextStyles.header3(
                  text: "Remaining",
                  color: Colors.black,
                  fontWeight: FontWeight.bold),
              SizedBox(
                height: 10.h,
              ),
              TextStyles.nominal1(
                  text: budgetEntity.totalRemain.toString() ?? "",
                  color: Colors.black),
              SizedBox(
                height: 10.h,
              ),
              LinearPercentIndicator(
                padding: EdgeInsets.symmetric(horizontal: 32),
                animation: true,
                lineHeight: 20.0,
                animationDuration: 2500,
                percent: budgetEntity.totalPersentase,
                center: Text("${budgetEntity.textPersent}%"),
                barRadius: Radius.circular(20.r),
                progressColor: Colors.green,
              ),
              SizedBox(
                height: 20.h,
              ),
              budgetEntity.exceedLimit
                  ? Container(
                      padding:
                          EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(24.r),
                          color: ColorName.red),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Ionicons.alert_circle_sharp,
                            color: Colors.white,
                            size: 24.sp,
                          ),
                          SizedBox(
                            width: 10.w,
                          ),
                          TextStyles.body2(
                              text: "You’ve exceed the limit",
                              color: Colors.white),
                        ],
                      ),
                    )
                  : const SizedBox()
            ],
          ),
        )),
        bottomSheet: Container(
          height: 130.h,
          padding:
              const EdgeInsets.only(left: 15, right: 15, top: 20, bottom: 50),
          color: Colors.transparent,
          child: ButtonStyles.ButtonNotIcon(
              backGroundColor: ColorName.purple,
              foreGroundColor: ColorName.whiteBackground,
              label: "Edit",
              onTap: () {
                budgetRouter.navigateToEditBudget(budgetEntity);
              }),
        ),
      ),
    );
  }
}
