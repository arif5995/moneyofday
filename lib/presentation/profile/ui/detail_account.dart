import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import 'package:monday/datasource/model/wallet_bank_model.dart';
import 'package:monday/domain/entities/transaction_entity.dart';
import 'package:monday/injections/injections.dart';
import 'package:monday/presentation/profile/bloc/profile_cubit.dart';
import 'package:monday/utils/constant/app_constant.dart';
import 'package:monday/utils/currency/currency_format.dart';
import 'package:monday/utils/gen/assets.gen.dart';
import 'package:monday/utils/gen/colors.gen.dart';
import 'package:monday/utils/navigation/router/profile_router.dart';
import 'package:monday/utils/state/view_data_state.dart';
import 'package:monday/utils/widget/item_transaction_custom.dart';
import 'package:monday/utils/widget/text_style.dart';
import 'package:sticky_grouped_list/sticky_grouped_list.dart';

class DetailAccount extends StatelessWidget {
  final ProfileRouter profileRouter = sl();
  final WalletBankModel walletBankModel;

  DetailAccount({super.key, required this.walletBankModel});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorName.whiteBackground,
      appBar: AppBar(
        backgroundColor: ColorName.whiteBackground,
        leading: IconButton(
          onPressed: () {
            profileRouter.navigateToAccount();
          },
          icon: Icon(
            Icons.arrow_back,
            color: Colors.black,
            size: 25.sp,
          ),
        ),
        title: TextStyles.body2(text: "Detail Account"),
      ),
      body: Container(
        width: MediaQuery.of(context).size.width,
        padding: EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              height: 31.h,
            ),
            Container(
              height: 48.h,
              width: 48.w,
              padding: const EdgeInsets.all(7),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16.r),
                  color: ColorName.grey),
              child: SvgPicture.asset(walletBankModel.assetBank.isNotEmpty
                  ? walletBankModel.assetBank
                  : Assets.images.icons.wallet.path),
            ),
            SizedBox(
              height: 8.h,
            ),
            TextStyles.header2(
              text: walletBankModel.nameBank,
              color: Colors.black,
            ),
            SizedBox(
              height: 12.h,
            ),
            TextStyles.header1(
              text: CurrencyFormat.convertToIdr(walletBankModel.walletData.price, 0),
              color: Colors.black,
            ),
            SizedBox(
              height: 55.h,
            ),
            SizedBox(
              child: BlocBuilder<ProfileCubit, ProfileState>(
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
                          return ItemTransaction(
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
                              // transactionRouter.navigateToDetailTransaction(element);
                            },
                          );
                        },
                      );
                    } else {
                      return Center(child: TextStyles.body2(text: "No Transactions"));
                    }
                  }
                  return const SizedBox();
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
