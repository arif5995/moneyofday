import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:monday/domain/entities/transaction_entity.dart';
import 'package:monday/injections/injections.dart';
import 'package:monday/presentation/home/bloc/home_bloc/home_cubit.dart';
import 'package:monday/utils/constant/app_constant.dart';
import 'package:monday/utils/currency/currency_format.dart';
import 'package:monday/utils/gen/colors.gen.dart';
import 'package:monday/utils/navigation/router/auth_router.dart';
import 'package:monday/utils/widget/button_style.dart';
import 'package:monday/utils/widget/my_separator.dart';
import 'package:monday/utils/widget/text_style.dart';

class DetailItemTransaction extends StatelessWidget {
  final TransactionEntity argument;

  DetailItemTransaction({super.key, required this.argument});

  final AuthRouter authRouter = sl();

  Color setColor() {
    if (argument.idTransaction == AppConstants.transaction.expanse) {
      return ColorName.red;
    } else if (argument.idTransaction == AppConstants.transaction.income) {
      return ColorName.green;
    } else {
      return ColorName.blue;
    }
  }

  String dateItem() {
    final formatGroupDate = DateFormat("EEEE dd MMMM yyyy HH:mm");
    return formatGroupDate.format(argument.date);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorName.whiteBackground,
      appBar: AppBar(
        backgroundColor: setColor(),
        leading: IconButton(
          onPressed: () {
            authRouter.navigateToHome(index: 1);
          },
          icon: Icon(
            Icons.arrow_back,
            color: Colors.white,
            size: 24.sp,
          ),
        ),
        title: TextStyles.header3(text: "Detail Transaction"),
        actions: [
          IconButton(
            onPressed: () {
              showModalBottomSheet<void>(
                  context: context,
                  builder: (BuildContext context) {
                    return SizedBox(
                      height: 217,
                      child: Center(
                        child: Padding(
                          padding: const EdgeInsets.all(16),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            mainAxisSize: MainAxisSize.min,
                            children: <Widget>[
                              TextStyles.header3(
                                  text: "Remove this transaction?",
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold),
                              SizedBox(
                                height: 10.h,
                              ),
                              Text(
                                "Are you sure do you wanna remove this transaction?",
                                textAlign: TextAlign.center,
                                style: TextStyle(fontSize: 16.sp),
                              ),
                              SizedBox(
                                height: 16.h,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  SizedBox(
                                    width:164.w,
                                    height: 56.h,
                                    child: ButtonStyles.ButtonNotIcon(
                                        backGroundColor: ColorName.whitePurple,
                                        foreGroundColor: ColorName.grey,
                                        label: "No",
                                        colorText: ColorName.purple,
                                        onTap: () {}),
                                  ),
                                  SizedBox(
                                    width: 16.w,
                                  ),
                                  SizedBox(
                                    width:164.w,
                                    height: 56.h,
                                    child: ButtonStyles.ButtonNotIcon(
                                        backGroundColor: ColorName.purple,
                                        foreGroundColor: ColorName.grey,
                                        label: "Yes",
                                        onTap: () {}),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  });
            },
            icon: Icon(
              Icons.delete,
              color: Colors.white,
              size: 24.sp,
            ),
          )
        ],
      ),
      bottomSheet: Container(
        height: 100.h,
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
        color: Colors.white,
        child: ButtonStyles.ButtonNotIcon(
          backGroundColor: ColorName.purple,
          foreGroundColor: ColorName.whiteBackground,
          label: "Edit",
          onTap: () {},
        ),
      ),
      body: SingleChildScrollView(
        child: Stack(
          children: [
            Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              padding: EdgeInsets.symmetric(horizontal: 16),
              color: ColorName.whiteBackground,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                    height: 270.h,
                  ),
                  MySeparator(
                    color: Colors.grey,
                    height: 2.h,
                  ),
                  SizedBox(
                    height: 14.h,
                  ),
                  Align(
                    alignment: Alignment.topLeft,
                    child: TextStyles.body2(
                        text: "Description",
                        fontWeight: FontWeight.bold,
                        color: Colors.grey),
                  ),
                  SizedBox(
                    height: 15.h,
                  ),
                  Container(
                    width: 332.w,
                    height: 116.h,
                    padding: EdgeInsets.all(5),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8.r),
                        border: Border.all(color: Colors.grey)),
                    child: TextStyles.body2(
                        text: argument.description ?? "",
                        color: Colors.black,
                        textAlign: TextAlign.start),
                  ),

                  SizedBox(
                    height: 15.h,
                  ),
                  Align(
                    alignment: Alignment.topLeft,
                    child: TextStyles.body2(
                        text: "Attachment",
                        fontWeight: FontWeight.bold,
                        color: Colors.grey),
                  ),
                  SizedBox(
                    height: 15.h,
                  ),

                  /// Foto
                  Container(
                    width: 332.w,
                    height: 116.h,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8.r),
                        border: Border.all(color: Colors.grey)),
                    child: argument.pathImg != null
                        ? Image.file(
                            File(argument.pathImg!),
                            fit: BoxFit.fill,
                          )
                        : Center(
                            child: Icon(
                              Icons.image_outlined,
                              color: ColorName.grey,
                              size: 100.sp,
                            ),
                          ),
                  )
                ],
              ),
            ),
            Container(
              width: MediaQuery.of(context).size.width,
              height: 218.h,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(16.r),
                  bottomRight: Radius.circular(16.r),
                ),
                color: setColor(),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  TextStyles.header1(
                      text: CurrencyFormat.convertToIdr(
                          int.parse(argument.price), 0),
                      color: Colors.white),
                  SizedBox(
                    height: 10.h,
                  ),
                  TextStyles.body2(
                      text: dateItem(), color: ColorName.textWhite),
                  SizedBox(
                    height: 30.h,
                  )
                ],
              ),
            ),
            Positioned(
              top: 190,
              left: 16,
              right: 16,
              child: Container(
                height: 70.h,
                width: 343.w,
                padding: EdgeInsets.only(left: 16, right: 16),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12.r),
                  border: Border.all(color: ColorName.grey, width: 2.w),
                  color: Colors.white,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        TextStyles.body3(text: "Type", color: Colors.grey),
                        TextStyles.body2(
                            text: argument.categoryName ?? "",
                            color: Colors.black),
                      ],
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        TextStyles.body3(text: "Category", color: Colors.grey),
                        TextStyles.body2(
                            text: argument.categoryName.toString() ?? "",
                            color: Colors.black),
                      ],
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        TextStyles.body3(text: "Wallet", color: Colors.grey),
                        TextStyles.body2(
                            text: argument.walletName ?? "Cash",
                            color: Colors.black),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
