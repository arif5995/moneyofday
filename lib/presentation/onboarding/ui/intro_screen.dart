import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:monday/injections/injections.dart';
import 'package:monday/presentation/newAccount/bloc/account/account_cubit.dart';
import 'package:monday/utils/gen/colors.gen.dart';
import 'package:monday/utils/navigation/router/new_account_router.dart';
import 'package:monday/utils/state/view_data_state.dart';
import 'package:monday/utils/widget/button_style.dart';
import 'package:monday/utils/widget/text_style.dart';

class IntroScreen extends StatelessWidget {
  final NewAccountRouter newAccountRouter = sl();

  IntroScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<AccountCubit, AccountState>(
      listener: (context, state) {
        final status = state.bank.status;
        if (status.isHasData) {
          newAccountRouter.navigateToNewAccount();
        }
        if (status.isLoading) {
          showDialog(
            barrierDismissible: false,
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                content: Row(
                  children: [
                    const CircularProgressIndicator(),
                    Container(
                        margin: const EdgeInsets.only(left: 7),
                        child: const Text("Loading...")),
                  ],
                ),
              );
            },
          );
        }
      },
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SizedBox(
                height: 100.h,
              ),
              TextStyles.header1(text: "Let’s setup your\naccount!"),
              SizedBox(
                height: 25.h,
              ),
              TextStyles.body3(
                  text:
                      "Account can be your bank, credit card or\nyour wallet."),
            ],
          ),
        ),
        bottomSheet: Container(
          height: 100.h,
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
          color: Colors.white,
          child: ButtonStyles.ButtonNotIcon(
              backGroundColor: ColorName.purple,
              foreGroundColor: ColorName.whiteBackground,
              label: "Let's go",
              onTap: () => context.read<AccountCubit>().checkingBankStatic()),
        ),
      ),
    );
  }
}
