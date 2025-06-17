import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import 'package:monday/injections/injections.dart';
import 'package:monday/presentation/home/bloc/home_bloc/home_cubit.dart';
import 'package:monday/utils/constant/app_constant.dart';
import 'package:monday/utils/currency/currency_format.dart';
import 'package:monday/utils/gen/assets.gen.dart';
import 'package:monday/utils/gen/colors.gen.dart';
import 'package:monday/utils/navigation/router/transaction_router.dart';
import 'package:monday/utils/state/view_data_state.dart';
import 'package:monday/utils/widget/chart_custom.dart';
import 'package:monday/utils/widget/display_financial_custom.dart';
import 'package:monday/utils/widget/item_transaction_custom.dart';
import 'package:monday/utils/widget/text_style.dart';

const List<String> listMonth = <String>[
  'January',
  'February',
  'Maret',
  'April',
  'Mei',
  'June',
  'July',
  'August',
  'September',
  'October',
  'November',
  'December'
];

const List<String> listPeriode = <String>[
  'Today',
  'Week',
  'Month',
  'Year',
];

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final now = DateTime.now();
  final TransactionRouter transactionRouter = sl();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorName.whiteBackground,
      body: SingleChildScrollView(
        physics: const ClampingScrollPhysics(),
        child: Column(
          children: [
            Container(
              width: 375.w,
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    ColorName.gradient1,
                    ColorName.gradient1,
                    ColorName.whiteBackground,
                  ],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                ),
              ),
              child: Column(
                children: [
                  SizedBox(
                    height: 40.h,
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.all(Radius.circular(25.r)),
                          child: Container(
                            width: 35.w,
                            height: 35.w,
                            color: ColorName.purple,
                            child: FadeInImage(
                                image: AssetImage(
                                    Assets.images.picture.penguin.path),
                                placeholder: AssetImage(
                                    Assets.images.picture.penguin.path),
                                fit: BoxFit.cover,
                                placeholderFit: BoxFit.cover,
                                alignment: Alignment.center,
                                fadeInDuration:
                                    const Duration(milliseconds: 100),
                                imageErrorBuilder:
                                    (context, error, stackTrace) {
                                  if (error is Exception) {
                                    return const SizedBox();
                                  }
                                  return const SizedBox();
                                }),
                          ),
                        ),
                        SizedBox(
                          width: 50.w,
                        ),
                        Container(
                          height: 30.h,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15.0),
                            border: Border.all(
                                color: ColorName.whitePurple,
                                style: BorderStyle.solid,
                                width: 0.80),
                          ),
                          child: BlocBuilder<HomeCubit, HomeState>(
                            builder: (context, state) {
                              final statusCurrentMonth = state.intMonth.status;

                              if (statusCurrentMonth.isHasData) {
                                final dataMonth = state.month.data;
                                final index = state.intMonth.data;
                                dynamic dropdownvalue =
                                    dataMonth![(index ?? 0) - 1];
                                return DropdownButton(
                                    key: const ValueKey("dry"),
                                    dropdownColor: Colors.white,
                                    iconSize: 24.sp,
                                    underline: const SizedBox(),
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 10),
                                    icon: Icon(
                                      Icons.keyboard_arrow_down,
                                      size: 20.sp,
                                      color: ColorName.purple,
                                    ),
                                    items: dataMonth.map((dynamic value) {
                                      return DropdownMenuItem(
                                          value: value,
                                          child: Text(value["name"],
                                              style: TextStyle(
                                                  fontWeight: FontWeight.normal,
                                                  fontSize: 14.sp,
                                                  color: Colors.black)));
                                    }).toList(),
                                    value: dropdownvalue,
                                    onChanged: (dynamic newValue) {
                                      dropdownvalue = newValue["name"];
                                      context
                                          .read<HomeCubit>()
                                          .currentMonth(index: newValue["key"]);
                                    });
                              }
                              return const SizedBox();
                            },
                          ),
                        ),
                        SizedBox(
                          width: 50.w,
                        ),
                        InkWell(
                          splashColor: ColorName.iconGrey,
                          onTap: () {},
                          child: Assets.images.icons.notifiaction
                              .svg(width: 32.sp, height: 32.sp),
                        ),
                      ],
                    ),
                  ),
                  TextStyles.body3(
                      text: "Account Balance", color: ColorName.textGrey),
                  SizedBox(
                    height: 9.h,
                  ),
                  TextStyles.header1(
                      text: CurrencyFormat.convertToIdr(
                          context
                                  .watch<HomeCubit>()
                                  .state
                                  .accountBalance
                                  .status
                                  .isHasData
                              ? context
                                  .watch<HomeCubit>()
                                  .state
                                  .accountBalance
                                  .data
                              : 0,
                          0)),
                  SizedBox(
                    height: 27.h,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                      left: 16,
                      right: 16,
                      bottom: 23,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        DisplayFinancialCustom(
                          background: ColorName.green,
                          assets: Assets.images.icons.income.svg(
                              width: 32.w,
                              height: 32.h,
                              color: ColorName.green),
                          title: 'Income',
                          price: context
                              .watch<HomeCubit>()
                              .state
                              .totalIncome
                              .data
                              .toString(),
                        ),
                        DisplayFinancialCustom(
                          background: ColorName.red,
                          assets: Assets.images.icons.expense.svg(
                              width: 32.w, height: 32.h, color: ColorName.red),
                          title: 'Expanse',
                          price: context
                              .watch<HomeCubit>()
                              .state
                              .totalExpanse
                              .data
                              .toString(),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 23.h,
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Align(
                  alignment: Alignment.topLeft,
                  child: TextStyles.header3(
                      text: "Spend Frequency", color: Colors.black)),
            ),
            SizedBox(
              height: 16.h,
            ),
            const LineChartSample2(),
            SizedBox(
              height: 8.5.h,
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width,
              height: 34.h,
              child: BlocBuilder<HomeCubit, HomeState>(
                builder: (context, state) {
                  final status = state.tabPeriod.status;
                  final listDate = state.tabDate.data;
                  if (status.isHasData) {
                    final data = state.tabPeriod.data;
                    return Center(
                      child: ListView.builder(
                          shrinkWrap: true,
                          scrollDirection: Axis.horizontal,
                          itemCount: data!.length,
                          itemBuilder: (BuildContext context, int index) {
                            final item = data[index];
                            return Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 1),
                              child: InkWell(
                                borderRadius: BorderRadius.circular(16.r),
                                splashColor: ColorName.whitePurple,
                                onTap: () {
                                  context
                                      .read<HomeCubit>()
                                      .tabPeriod(id: item.id);
                                },
                                child: Ink(
                                  width: 90.w,
                                  height: 34.h,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(16.r),
                                      color: item.tap
                                          ? ColorName.bacgroundYellow
                                          : Colors.white),
                                  child: Center(
                                    child: Text(
                                      item.name,
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 14.sp,
                                          color: item.tap
                                              ? ColorName.yellow
                                              : Colors.grey),
                                    ),
                                  ),
                                ),
                              ),
                            );
                          }),
                    );
                  }
                  return const SizedBox();
                },
              ),
            ),
            SizedBox(
              height: 16.h,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  TextStyles.header3(
                      text: "Recent Transaction", color: Colors.black),
                  InkWell(
                    borderRadius: BorderRadius.circular(16.r),
                    splashColor: ColorName.whitePurple,
                    onTap: () {},
                    child: Ink(
                      width: 90.w,
                      height: 34.h,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(16.r),
                          color: ColorName.whitePurple),
                      child: Center(
                        child: Text(
                          "See All",
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 14.sp,
                              color: ColorName.purple),
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
            SizedBox(
              child: BlocBuilder<HomeCubit, HomeState>(
                builder: (context, state) {
                  final status = state.listTransaction.status;
                  if (status.isHasData) {
                    final data = state.listTransaction.data;
                    if (data!.isNotEmpty) {
                      return ListView.builder(
                          shrinkWrap: true,
                          padding: const EdgeInsets.all(0),
                          physics: const ClampingScrollPhysics(),
                          itemCount: data.length,
                          itemBuilder: (BuildContext context, int index) {
                            final formatTime = DateFormat("HH:mm");
                            final element = data[index];
                            SvgPicture? svgPicture;
                            Color? colorBackground;
                            Color? colorPrice;
                            if (element.categoryName ==
                                AppConstants.category.shopping) {
                              svgPicture = Assets.images.icons.bagshopping.svg(
                                  width: 40.w,
                                  height: 40.h,
                                  color: ColorName.yellow);
                              colorBackground = ColorName.bacgroundYellowIcon;
                              colorPrice = ColorName.red;
                            } else if (element.categoryName ==
                                AppConstants.category.subscription) {
                              svgPicture = Assets.images.icons.subscriptions
                                  .svg(
                                      width: 40.w,
                                      height: 40.h,
                                      color: ColorName.purple);
                              colorBackground = ColorName.whitePurple;
                              colorPrice = ColorName.red;
                            } else if (element.categoryName ==
                                AppConstants.category.food) {
                              svgPicture = Assets.images.icons.restaurant.svg(
                                  width: 40.w,
                                  height: 40.h,
                                  color: ColorName.red);
                              colorBackground = ColorName.bacgroundRedIcon;
                              colorPrice = ColorName.red;
                            } else if (element.categoryName ==
                                AppConstants.category.salary) {
                              svgPicture = Assets.images.icons.salary.svg(
                                  width: 40.w,
                                  height: 40.h,
                                  color: ColorName.green);
                              colorBackground = ColorName.bacgroundGreenIcon;
                              colorPrice = ColorName.green;
                            } else if (element.categoryName ==
                                AppConstants.category.transportation) {
                              svgPicture = Assets.images.icons.car.svg(
                                  width: 40.w,
                                  height: 40.h,
                                  color: ColorName.blue);
                              colorBackground = ColorName.bacgroundBlueIcon;
                              colorPrice = ColorName.red;
                            } else {
                              svgPicture = Assets.images.icons.transactionFab
                                  .svg(width: 40.w, height: 40.h);
                              colorBackground = ColorName.whitePurple;
                              colorPrice = ColorName.green;
                            }
                            return Padding(
                              padding: const EdgeInsets.only(
                                  left: 16, right: 16, bottom: 9),
                              child: ItemTransaction(
                                asset: svgPicture,
                                title: element.categoryName ?? "",
                                subtitle: element.description ?? "",
                                price: element.idCategory ==
                                            AppConstants.category.salaryId ||
                                        element.idCategory ==
                                            AppConstants.category.transferId
                                    ? "+${CurrencyFormat.convertToIdr(int.parse(element.price), 0)}"
                                    : "-${CurrencyFormat.convertToIdr(int.parse(element.price), 0)}",
                                clock: formatTime.format(element.date),
                                colorBackgroundIcon: colorBackground,
                                colorPrice: colorPrice,
                                onTap: () {
                                  transactionRouter
                                      .navigateToDetailTransaction(element);
                                },
                              ),
                            );
                          });
                    }
                  }
                  return SizedBox(
                    child: Center(
                      child: TextStyles.body3(text: "No Transactions"),
                    ),
                  );
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
