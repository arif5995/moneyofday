import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:monday/injections/injections.dart';
import 'package:monday/presentation/profile/bloc/profile_cubit.dart';
import 'package:monday/utils/currency/currency_format.dart';
import 'package:monday/utils/gen/assets.gen.dart';
import 'package:monday/utils/gen/colors.gen.dart';
import 'package:monday/utils/navigation/router/profile_router.dart';
import 'package:monday/utils/state/view_data_state.dart';
import 'package:monday/utils/widget/button_style.dart';
import 'package:monday/utils/widget/item_wallet.dart';
import 'package:monday/utils/widget/text_style.dart';

class AccountScreen extends StatelessWidget {
  final ProfileRouter profileRouter = sl();

  AccountScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorName.whiteBackground,
      appBar: AppBar(
        backgroundColor: ColorName.whiteBackground,
        leading: IconButton(
          onPressed: () {
            profileRouter.navigateToHome(index: 3);
          },
          icon: Icon(
            Icons.arrow_back,
            color: Colors.black,
            size: 25.sp,
          ),
        ),
        title: TextStyles.body2(text: "Account"),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Stack(
              alignment: Alignment.center,
              children: [
                Container(
                    color: Colors.white,
                    width: MediaQuery
                        .of(context)
                        .size
                        .width,
                    height: 150.h,
                    child: Assets.images.background.backgroundAccount
                        .svg(fit: BoxFit.cover)),
                Center(
                    child: Column(
                      children: [
                        TextStyles.body3(
                            text: "Account Balance", color: ColorName.textGrey),
                        SizedBox(
                          height: 8.h,
                        ),
                        BlocBuilder<ProfileCubit, ProfileState>(
                          builder: (context, state) {
                            final status = state.totalWallet.status;
                            if (status.isHasData){
                              final data = state.totalWallet.data;
                              return TextStyles.header1(
                                  text: CurrencyFormat.convertToIdr(data,0), color: Colors.black);
                            }
                            return TextStyles.header1(
                                text: "Rp. 0", color: Colors.black);
                          },
                        ),
                      ],
                    ))
              ],
            ),
            BlocBuilder<ProfileCubit, ProfileState>(
              builder: (context, state) {
                final status = state.listWallet.status;
                final data = state.listWallet.data;
                if (status.isHasData) {
                  return ListView.builder(
                    itemCount: data!.length,
                    shrinkWrap: true,
                    itemBuilder: (BuildContext context, int index) {
                      final item = data[index];
                      return ItemWallet(
                          onTap: () {
                            profileRouter.navigateToDetailAccount(item);
                            print("detail");
                          },
                          name: item.nameBank,
                          price: CurrencyFormat.convertToIdr(item.walletData
                              .price, 0),
                          svg: SvgPicture.asset(item.assetBank.isNotEmpty ? item
                              .assetBank : Assets.images.icons.wallet.path));
                    },
                  );
                } else {
                  return Center(
                    child: TextStyles.header2(text: "Wallet is empty"),);
                }
              },
            )
          ],
        ),
      ),
      bottomSheet: Container(
        height: 100.h,
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
        color: Colors.white,
        child: ButtonStyles.ButtonIcon(
          backGroundColor: ColorName.purple,
          foreGroundColor: ColorName.whiteBackground,
          label: "Add new wallet",
          icon: Icon(
            Icons.add,
            color: Colors.white,
            size: 24.sp,
          ),
          onTap: () {
            profileRouter.navigateToAddNewAccount();
          },
        ),
      ),
    );
  }
}
