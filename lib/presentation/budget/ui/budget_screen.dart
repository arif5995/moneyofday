import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ionicons/ionicons.dart';
import 'package:monday/injections/injections.dart';
import 'package:monday/presentation/budget/bloc/budget_cubit.dart';
import 'package:monday/utils/gen/colors.gen.dart';
import 'package:monday/utils/navigation/router/budget_router.dart';
import 'package:monday/utils/state/view_data_state.dart';
import 'package:monday/utils/widget/button_style.dart';
import 'package:monday/utils/widget/item_budget.dart';
import 'package:monday/utils/widget/text_style.dart';
import 'package:percent_indicator/percent_indicator.dart';

class BudgetScreeen extends StatelessWidget {
  final BudgetRouter budgetRouter = sl();

  BudgetScreeen({super.key});

  @override
  Widget build(BuildContext context) {
    Animation<Color> animation;
    return Scaffold(
      backgroundColor: ColorName.purple,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(60.h),
        child: Padding(
          padding: const EdgeInsets.only(top: 60, left: 16, right: 16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              IconButton(
                onPressed: () {
                  context.read<BudgetCubit>().leftMonth();
                },
                icon: Icon(
                  Icons.arrow_back_ios_new_outlined,
                  color: Colors.white,
                  size: 25.sp,
                ),
              ),
              BlocBuilder<BudgetCubit, BudgetState>(
                builder: (context, state) {
                  final status = state.month.status;
                  if (status.isHasData) {
                    final data = state.month.data;
                    return TextStyles.header2(text: data ?? "");
                  }
                  return const SizedBox();
                },
              ),
              IconButton(
                onPressed: () {
                  context.read<BudgetCubit>().rightMonth();
                },
                icon: Icon(
                  Icons.arrow_forward_ios,
                  color: Colors.white,
                  size: 25.sp,
                ),
              ),
            ],
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: [
            SizedBox(height: 30.h,),
            Container(
              width: MediaQuery
                  .of(context)
                  .size
                  .width,
              height: 665.h,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                  topRight: Radius.circular(24.r),
                  topLeft: Radius.circular(24.r),
                ),
                color: Colors.white,
              ),
              child: Padding(
                padding: const EdgeInsets.only(top: 30, bottom: 120),
                child: SizedBox(
                  child: BlocBuilder<BudgetCubit, BudgetState>(
                    builder: (context, state) {
                      final status = state.listBudget.status;
                      if (status.isHasData){
                        final data = state.listBudget.data;
                        return ListView.builder(
                            shrinkWrap: true,
                            itemCount: data!.length,
                            itemBuilder: (ctx, index) {
                              final item = data[index];
                              return ItemBudget(
                                budgetEntity: item,
                                onTap: (){
                                  budgetRouter.navigateToDetailBudget(item);
                                },
                              );
                            });
                      } else {
                        return Center(
                          child: TextStyles.body2(
                              text:
                              "You don’t have a budget.\nLet’s make one so you in control.",
                              color: ColorName.textGrey),
                        );
                      }
                    },
                  ),
                ),
              ),

            ),
          ],
        ),
      ),
      bottomSheet: Container(
        height: 130.h,
        padding:
        const EdgeInsets.only(left: 15, right: 15, top: 20, bottom: 50),
        color: Colors.white,
        child: ButtonStyles.ButtonNotIcon(
            backGroundColor: ColorName.purple,
            foreGroundColor: ColorName.whiteBackground,
            label: "Create a budget",
            onTap: () {
              budgetRouter.navigateToCreateBudget();
            }),
      ),
    );
  }
}
