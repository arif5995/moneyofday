import 'dart:io';

import 'package:currency_text_input_formatter/currency_text_input_formatter.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:monday/domain/entities/category_transaction_entity.dart';
import 'package:monday/injections/injections.dart';
import 'package:monday/presentation/budget/bloc/budget_cubit.dart';
import 'package:monday/utils/gen/colors.gen.dart';
import 'package:monday/utils/navigation/router/auth_router.dart';
import 'package:monday/utils/state/view_data_state.dart';
import 'package:monday/utils/widget/button_style.dart';
import 'package:monday/utils/widget/text_style.dart';

class CreateBudgetScreen extends StatefulWidget {
  CreateBudgetScreen({super.key});

  static final GlobalKey<FormFieldState> _balanceFormKey =
  GlobalKey<FormFieldState>();

  @override
  State<CreateBudgetScreen> createState() => _CreateBudgetScreenState();
}

class _CreateBudgetScreenState extends State<CreateBudgetScreen> {
  final AuthRouter authRouter = sl();

  CategoryTransactionEntity? currentCategory;

  TextEditingController textEditingControllerBalance = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocListener<BudgetCubit, BudgetState>(
      listener: (context, state) {
       final status = state.insertBudget.status;
       if (status.isHasData){
          authRouter.navigateToHome(index: 2);
       }
      },
      child: Scaffold(
        backgroundColor: ColorName.purple,
        appBar: AppBar(
          leading: IconButton(
            onPressed: () {
              authRouter.navigateToHome(index: 2);
            },
            icon: Icon(
              Icons.arrow_back,
              color: Colors.white,
              size: 24.sp,
            ),
          ),
          title: TextStyles.header2(text: "Create Budget"),
          backgroundColor: ColorName.purple,
        ),
        bottomSheet: Container(
          height: 130.h,
          padding:
          const EdgeInsets.only(left: 15, right: 15, top: 20, bottom: 50),
          color: Colors.transparent,
          child: ButtonStyles.ButtonNotIcon(
              backGroundColor: ColorName.purple,
              foreGroundColor: ColorName.whiteBackground,
              label: "Continue",
              onTap: () {
                context.read<BudgetCubit>().insertBudget(
                    price: textEditingControllerBalance.text,
                    category: currentCategory!);
              }),
        ),
        body: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 254.h,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: TextStyles.header3(
                    text: "How much do yo want to spend?",
                    color: ColorName.greytipis),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: TextFormField(
                  key: CreateBudgetScreen._balanceFormKey,
                  controller: textEditingControllerBalance,
                  textAlign: TextAlign.start,
                  cursorColor: Colors.white,
                  // textInputAction: TextInputAction.done,
                  keyboardType: TextInputType.number,
                  inputFormatters: [
                    FilteringTextInputFormatter.digitsOnly,
                    CurrencyTextInputFormatter.currency(
                        locale: 'id', symbol: "", decimalDigits: 0)
                  ],
                  style: TextStyle(
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                      fontSize: 64.sp),
                  // onFieldSubmitted: (term) {
                  //   FocusScope.of(context).requestFocus(focusName);
                  // },
                  decoration: InputDecoration(
                    suffixText: "IDR",
                    suffixStyle: TextStyle(
                        color: Colors.white,
                        fontSize: 14.sp,
                        fontWeight: FontWeight.bold),
                    border: InputBorder.none,
                    focusedBorder: InputBorder.none,
                    enabledBorder: InputBorder.none,
                    errorBorder: InputBorder.none,
                    disabledBorder: InputBorder.none,
                    hintText: "0",
                    hintStyle: TextStyle(
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
                        fontSize: 64.sp),
                  ),
                ),
              ),
              SizedBox(height: 18.h),
              Container(
                height: 370.h,
                padding: const EdgeInsets.symmetric(
                    horizontal: 16, vertical: 24),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(32.r),
                      topRight: Radius.circular(32.r)),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      spreadRadius: 5,
                      blurRadius: 7,
                      offset: const Offset(2, 3), // changes position of shadow
                    ),
                  ],
                  color: ColorName.whiteBackground,
                ),
                child: Column(
                  children: [
                    BlocBuilder<BudgetCubit, BudgetState>(
                      builder: (context, state) {
                        final status = state.listCategory.status;
                        if (status.isHasData) {
                          final category = state.listCategory.data;
                          return DropdownButtonFormField(
                            dropdownColor: Colors.white,
                            items: category
                                ?.map((CategoryTransactionEntity category) {
                              return DropdownMenuItem(
                                  value: category, child: Text(category.name));
                            }).toList(),
                            onChanged: (newValue) {
                              currentCategory = newValue;
                            },
                            value: currentCategory,
                              hint: TextStyles.body2(text: "Select category"),
                            decoration: InputDecoration(
                              // Set border for enabled state (default)
                              enabledBorder: OutlineInputBorder(
                                borderSide: const BorderSide(
                                    width: 1, color: ColorName.textGrey),
                                borderRadius: BorderRadius.circular(15),
                              ),
                              // Set border for focused state
                              focusedBorder: OutlineInputBorder(
                                borderSide: const BorderSide(
                                    width: 1, color: ColorName.textGrey),
                                borderRadius: BorderRadius.circular(15),
                              ),
                              // errorText: errorSnapshot.data == 0 ? Localization.of(context).categoryEmpty : null
                            ),
                          );
                        }
                        return const SizedBox();
                      },
                    ),
                    SizedBox(
                      height: 30.h,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Expanded(
                          flex: 8,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              TextStyles.body2(
                                  text: "Receive Alert",
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold),
                              TextStyles.body4(
                                  text:
                                  "Receive alert when it reaches some point.",
                                  color: Colors.grey)
                            ],
                          ),
                        ),
                        SizedBox(
                          width: 80.w,
                        ),
                        Expanded(
                          flex: 3,
                          child: BlocBuilder<BudgetCubit, BudgetState>(
                            builder: (context, state) {
                              final data = state.isNotice.data;
                              return Switch(
                                value: data ?? false,
                                activeColor: ColorName.purple,
                                onChanged: (bool value) {
                                  context
                                      .read<BudgetCubit>()
                                      .changeNotice(isNotice: value);
                                },
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
