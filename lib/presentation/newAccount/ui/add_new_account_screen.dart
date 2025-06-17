import 'package:currency_text_input_formatter/currency_text_input_formatter.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:monday/injections/injections.dart';
import 'package:monday/presentation/newAccount/bloc/account/account_cubit.dart';
import 'package:monday/utils/gen/colors.gen.dart';
import 'package:monday/utils/navigation/router/new_account_router.dart';
import 'package:monday/utils/state/view_data_state.dart';
import 'package:monday/utils/widget/button_style.dart';
import 'package:monday/utils/widget/text_field_custom.dart';
import 'package:monday/utils/widget/text_style.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';

const List<String> acountType = <String>["Account Type", "Bank", "Wallet"];

class AddNewAccountScreen extends StatefulWidget {

  const AddNewAccountScreen({super.key});

  static final GlobalKey<FormFieldState> _balanceFormKey =
      GlobalKey<FormFieldState>();
  static final GlobalKey<FormFieldState> _nameFormKey =
      GlobalKey<FormFieldState>();
  static final GlobalKey<FormFieldState> _bankFormKey =
      GlobalKey<FormFieldState>();

  @override
  State<AddNewAccountScreen> createState() => _AddNewAccountScreenState();
}

class _AddNewAccountScreenState extends State<AddNewAccountScreen> {
  final NewAccountRouter newAccountRouter = sl();

  String currentValue = acountType.first;

  FocusNode focusName = FocusNode();

  FocusNode focusDropdown = FocusNode();

  TextEditingController textEditingControllerName = TextEditingController();

  TextEditingController textEditingControllerBalance = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocListener<AccountCubit, AccountState>(
      listener: (context, state) {
        final status = state.insertWallet.status;
        final data = state.insertWallet.data;
        if (status.isHasData) {
          if (data == true) {
            newAccountRouter.navigateToSuccess();
          }
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

        if (status.isError) {
          showTopSnackBar(
            Overlay.of(context),
            CustomSnackBar.info(
              message: state.insertWallet.message,
            ),
          );
        }
      },
      child: Scaffold(
        backgroundColor: ColorName.purple,
        appBar: AppBar(
          backgroundColor: ColorName.purple,
          elevation: 0,
          title: TextStyles.header3(text: "Add new account"),
        ),
        bottomSheet: Container(
          height: 100.h,
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
          color: Colors.white,
          child: ButtonStyles.ButtonNotIcon(
              backGroundColor: ColorName.purple,
              foreGroundColor: ColorName.whiteBackground,
              label: "Continue",
              onTap: () {
                context.read<AccountCubit>().insertNewWallet(
                    balance: textEditingControllerBalance.text,
                    name: textEditingControllerName.text);
              }),
        ),
        body: ListView(
          physics: const ClampingScrollPhysics(),
          children: [
            SizedBox(
              height: 250.h,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 15),
              child: TextStyles.header3(
                  text: "Balance", color: ColorName.textGrey),
            ),
            SizedBox(
              height: 10.h,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: TextFormField(
                key: AddNewAccountScreen._balanceFormKey,
                controller: textEditingControllerBalance,
                textAlign: TextAlign.start,
                cursorColor: Colors.white,
                textInputAction: TextInputAction.next,
                // keyboardType: TextInputType.number,
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
            SizedBox(
              height: 10.h,
            ),
            Container(
              height: MediaQuery.of(context).size.height,
              padding: const EdgeInsets.all(10),
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
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 20.h,
                  ),
                  TextFieldCustom.textFieldNormal(
                      key: AddNewAccountScreen._nameFormKey,
                      controller: textEditingControllerName,
                      focusNode: focusName,
                      hint: "Name",
                      onTap: () {
                        Scrollable.ensureVisible(AddNewAccountScreen._nameFormKey.currentContext!);
                      }),
                  SizedBox(
                    height: 15.h,
                  ),
                  DropdownButtonFormField(
                    key: AddNewAccountScreen._bankFormKey,
                    dropdownColor: Colors.white,
                    items: acountType.map((String category) {
                      return DropdownMenuItem(
                        value: category,
                        child: Text(category),
                      );
                    }).toList(),
                    onChanged: (newValue) {
                      setState(() => currentValue = newValue ?? "");
                      Scrollable.of(AddNewAccountScreen._bankFormKey.currentContext!);
                      context
                          .read<AccountCubit>()
                          .initiateAccountType(accType: newValue ?? "");
                    },
                    value: currentValue,
                    validator: (val) {
                      if (val == currentValue[0]) {
                        return 'Please select account type';
                      }
                      return null;
                    },
                    decoration: InputDecoration(
                      // Set border for enabled state (default)
                      enabledBorder: OutlineInputBorder(
                        borderSide: const BorderSide(width: 1, color: ColorName.textGrey),
                        borderRadius: BorderRadius.circular(15),
                      ),
                      // Set border for focused state
                      focusedBorder: OutlineInputBorder(
                        borderSide: const BorderSide(width: 1, color: ColorName.textGrey),
                        borderRadius: BorderRadius.circular(15),
                      ),
                      // errorText: errorSnapshot.data == 0 ? Localization.of(context).categoryEmpty : null
                    ),
                  ),
                  SizedBox(
                    height: 10.h,
                  ),
                  BlocBuilder<AccountCubit, AccountState>(
                    builder: (context, state) {
                      final status =
                          context.watch<AccountCubit>().state.bank.status;
                      if (status.isHasData) {
                        if (state.bank.data!.isNotEmpty) {
                          return Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              TextStyles.header3(
                                  text: "Bank", color: Colors.black),
                              SizedBox(
                                height: 10.h,
                              ),
                              GridView.builder(
                                  shrinkWrap: true,
                                  gridDelegate:
                                      const SliverGridDelegateWithMaxCrossAxisExtent(
                                          maxCrossAxisExtent: 100,
                                          childAspectRatio: 1.5,
                                          crossAxisSpacing: 20,
                                          mainAxisSpacing: 20),
                                  itemCount: (state.bank.data?.length ?? 0),
                                  itemBuilder: (BuildContext ctx, index) {
                                    final image = state.bank.data![index];
                                    if (index < state.bank.data!.length - 1) {
                                      return Stack(
                                        children: [
                                          Container(
                                            decoration: BoxDecoration(
                                                border: Border.all(
                                                    color: ColorName.purple,
                                                    width: 1),
                                                borderRadius: BorderRadius.all(
                                                  Radius.circular(8.r),
                                                ),
                                                color: image.enable!
                                                    ? ColorName.whitePurple
                                                    : Colors.transparent),
                                          ),
                                          Center(
                                            child:
                                                SvgPicture.asset(image.image),
                                          ),
                                          Positioned.fill(
                                            child: Material(
                                              color: Colors.transparent,
                                              child: InkWell(
                                                borderRadius:
                                                    BorderRadius.circular(8.r),
                                                onTap: () {
                                                  context
                                                      .read<AccountCubit>()
                                                      .selectedBank(
                                                          id: image.idBank ?? "");
                                                },
                                              ),
                                            ),
                                          ),
                                        ],
                                      );
                                    } else {
                                      return Material(
                                        color: Colors.transparent,
                                        child: InkWell(
                                            borderRadius:
                                                BorderRadius.circular(8.r),
                                            onTap: () {},
                                            child: Container(
                                              decoration: BoxDecoration(
                                                  border: Border.all(
                                                      color: ColorName.purple,
                                                      width: 1),
                                                  borderRadius:
                                                      BorderRadius.all(
                                                          Radius.circular(
                                                              8.r))),
                                              child: Center(
                                                  child: TextStyles.body3(
                                                      text: "See Other")),
                                            )),
                                      );
                                    }
                                  }),
                            ],
                          );
                        }
                      }
                      return Container(
                        color: Colors.red,
                      );
                    },
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
