import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import 'package:monday/domain/entities/transaction_entity.dart';
import 'package:monday/injections/injections.dart';
import 'package:monday/presentation/home/bloc/home_bloc/home_cubit.dart';
import 'package:monday/presentation/transaction/bloc/transaction_cubit.dart';
import 'package:monday/utils/constant/app_constant.dart';
import 'package:monday/utils/currency/currency_format.dart';
import 'package:monday/utils/gen/assets.gen.dart';
import 'package:monday/utils/gen/colors.gen.dart';
import 'package:monday/utils/navigation/router/transaction_router.dart';
import 'package:monday/utils/state/view_data_state.dart';
import 'package:monday/utils/widget/item_transaction_custom.dart';
import 'package:monday/utils/widget/text_style.dart';
import 'package:sticky_grouped_list/sticky_grouped_list.dart';

class TransactionScreen extends StatefulWidget {
  TransactionScreen({super.key});

  @override
  State<TransactionScreen> createState() => _TransactionScreenState();
}

class _TransactionScreenState extends State<TransactionScreen> {
  final TransactionRouter transactionRouter = sl();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: ColorName.whiteBackground,
        appBar: PreferredSize(
            preferredSize: const Size.fromHeight(145),
            child: Padding(
              padding: const EdgeInsets.only(top: 60, left: 16, right: 16),
              child: Container(
                color: Colors.white,
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          height: 35.h,
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
                              dynamic dropdownvalue = dataMonth![(index ?? 0)-1];
                              return DropdownButton(
                                  key: const ValueKey("dry"),
                                  iconSize: 24.sp,
                                  underline: const SizedBox(),
                                  dropdownColor: Colors.white,
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
                                    context.read<HomeCubit>().currentMonth(index: newValue["key"]);
                                    context.read<TransactionCubit>().getListTransaction(month: newValue["key"]);
                                  }
                              );
                              }
                              return const SizedBox();
                            },
                          ),
                        ),
                        Container(
                          width: 40.w,
                          height: 40.h,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8.r),
                              border: Border.all(
                                  color: ColorName.whitePurple,
                                  style: BorderStyle.solid,
                                  width: 0.80)),
                          child: Center(
                              child: Assets.images.icons.sort
                                  .svg(width: 32.w, height: 32.h)),
                        )
                      ],
                    ),
                    SizedBox(
                      height: 15.h,
                    ),
                    Material(
                      child: InkWell(
                        borderRadius: BorderRadius.circular(8.r),
                        splashColor: ColorName.whitePurple,
                        onTap: () {},
                        child: Ink(
                          width: 343.w,
                          height: 48.h,
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8.r),
                              color: ColorName.whitePurple),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              TextStyles.body2(
                                  text: "See your financial report",
                                  color: ColorName.purple),
                              const Icon(
                                Icons.arrow_forward_ios,
                                size: 24,
                                color: ColorName.purple,
                              ),
                            ],
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            )),
        body: BlocBuilder<TransactionCubit, TransactionState>(
          builder: (context, state) {
            final status = state.listTransaction.status;
            if (status.isHasData) {
              final data = state.listTransaction.data;
              if (data!.isNotEmpty) {
                return StickyGroupedListView<TransactionEntity, DateTime>(
                  padding: const EdgeInsets.all(0),
                  shrinkWrap: true,
                  stickyHeaderBackgroundColor: Colors.white,
                  elements: data,
                  groupBy: (TransactionEntity transactionEntity) => DateTime(
                    transactionEntity.date.year,
                    transactionEntity.date.month,
                    transactionEntity.date.day,
                  ),
                  groupComparator: (DateTime value1, DateTime value2) =>
                      value2.compareTo(value1),
                  groupSeparatorBuilder: (TransactionEntity transactionEntity) {
                    final formatGroupDate = DateFormat("MMMM dd, yyyy");
                    final now = DateTime.now();
                    final today = DateTime(now.year, now.month, now.day);
                    final yesterday =
                        DateTime(now.year, now.month, now.day - 1);
                    // final tomorrow =
                    // DateTime(now.year, now.month, now.day + 1);
                    final dateTransaction = DateTime(
                        transactionEntity.date.year,
                        transactionEntity.date.month,
                        transactionEntity.date.day);
                    if (dateTransaction == today) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 9, horizontal: 16),
                        child: Container(
                            child: TextStyles.header3(
                                text: "Today", color: Colors.black)),
                      );
                    } else if (dateTransaction == yesterday) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 9, horizontal: 16),
                        child: TextStyles.header3(
                            text: "Yesterday", color: Colors.black),
                      );
                    } else {
                      return Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 9, horizontal: 16),
                        child: TextStyles.header3(
                            text:
                                formatGroupDate.format(transactionEntity.date),
                            color: Colors.black),
                      );
                    }
                  },
                  itemBuilder: (context, element) {
                    final formatTime = DateFormat("HH:mm");
                    SvgPicture? svgPicture;
                    Color? colorBackground;
                    Color? colorPrice;
                    if (element.categoryName ==
                        AppConstants.category.shopping) {
                      svgPicture = Assets.images.icons.bagshopping.svg(
                          width: 40.w, height: 40.h, color: ColorName.yellow);
                      colorBackground = ColorName.bacgroundYellowIcon;
                      colorPrice = ColorName.red;
                    } else if (element.categoryName ==
                        AppConstants.category.subscription) {
                      svgPicture = Assets.images.icons.subscriptions.svg(
                          width: 40.w, height: 40.h, color: ColorName.purple);
                      colorBackground = ColorName.whitePurple;
                      colorPrice = ColorName.red;
                    } else if (element.categoryName ==
                        AppConstants.category.food) {
                      svgPicture = Assets.images.icons.restaurant
                          .svg(width: 40.w, height: 40.h, color: ColorName.red);
                      colorBackground = ColorName.bacgroundRedIcon;
                      colorPrice = ColorName.red;
                    } else if (element.categoryName ==
                        AppConstants.category.salary) {
                      svgPicture = Assets.images.icons.salary.svg(
                          width: 40.w, height: 40.h, color: ColorName.green);
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
                      padding:
                          const EdgeInsets.only(left: 16, right: 16, bottom: 9),
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
                        onTap: (){
                          transactionRouter.navigateToDetailTransaction(element);
                        },
                      ),
                    );
                  },
                );
              } else {
                return Center(child: TextStyles.body2(text: "No Transactions"));
              }
            }
            return const SizedBox();
          },
        ));
  }
}
