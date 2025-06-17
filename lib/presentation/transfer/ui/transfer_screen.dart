import 'package:camera/camera.dart';
import 'package:currency_text_input_formatter/currency_text_input_formatter.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:monday/datasource/model/wallet_bank_model.dart';
import 'package:monday/injections/injections.dart';
import 'package:monday/presentation/transfer/bloc/transfer_cubit.dart';
import 'package:monday/utils/gen/assets.gen.dart';
import 'package:monday/utils/gen/colors.gen.dart';
import 'package:monday/utils/navigation/router/auth_router.dart';
import 'package:monday/utils/state/view_data_state.dart';
import 'package:monday/utils/widget/button_style.dart';
import 'package:monday/utils/widget/camera_page.dart';
import 'package:monday/utils/widget/date_picker_custom.dart';
import 'package:monday/utils/widget/modal_bottom_attachment.dart';
import 'package:monday/utils/widget/text_field_custom.dart';
import 'package:monday/utils/widget/text_style.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';

class TransferScreen extends StatefulWidget {
  const TransferScreen({super.key});

  @override
  State<TransferScreen> createState() => _TransferScreenState();
}

class _TransferScreenState extends State<TransferScreen> {
  FocusNode myfocus = FocusNode();

  final AuthRouter authRouter = sl();

  TextEditingController textEditingControllerDescription =
      TextEditingController();
  TextEditingController textEditingControllerBalance = TextEditingController();
  TextEditingController textEditingControllerOtherCost =
      TextEditingController();

  final RestorableDateTime _selectedDate = RestorableDateTime(DateTime.now());

  void _selectDate(DateTime? newSelectedDate) {
    if (newSelectedDate != null) {
      setState(() {
        _selectedDate.value = newSelectedDate;
      });
    }
  }

  WalletBankModel? walletFrom;
  WalletBankModel? walletTo;

  @override
  Widget build(BuildContext context) {
    return BlocListener<TransferCubit, TransferState>(
      listener: (context, state) {
        final statusTransfer = state.insertTransfer.status;
        if (statusTransfer.isHasData) {
          showTopSnackBar(
            Overlay.of(context),
            const CustomSnackBar.success(
              message: "Succes",
            ),
          );
          authRouter.navigateToHome();
        }
      },
      child: Scaffold(
        backgroundColor: ColorName.blue,
        appBar: AppBar(
          elevation: 0,
          backgroundColor: ColorName.blue,
          leading: IconButton(
            onPressed: () {
              authRouter.navigateToHome();
            },
            icon: Icon(
              Icons.arrow_back,
              color: Colors.white,
              size: 24.sp,
            ),
          ),
          title:
              TextStyles.header3(text: "Transfer", fontWeight: FontWeight.bold),
        ),
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 206.h,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: TextStyles.header3(
                    text: "How Much?",
                    fontWeight: FontWeight.bold,
                    color: ColorName.bacgroundCard),
              ),
              SizedBox(
                height: 13.h,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: TextField(
                  textAlign: TextAlign.start,
                  cursorColor: Colors.white,
                  focusNode: myfocus,
                  controller: textEditingControllerBalance,
                  inputFormatters: [
                    CurrencyTextInputFormatter.currency(
                        locale: 'id', symbol: "", decimalDigits: 0)
                  ],
                  style: TextStyle(
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                      fontSize: 64.sp),
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
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
                height: 16.h,
              ),
              Container(
                width: MediaQuery.of(context).size.width,
                height: 460.h,
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(32.r),
                        topRight: Radius.circular(32.r)),
                    color: Colors.white),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          flex: 3,
                          child: BlocBuilder<TransferCubit, TransferState>(
                            builder: (context, state) {
                              final status = state.listWallet.status;
                              if (status.isHasData) {
                                final category = state.listWallet.data;

                                return DropdownButtonFormField(
                                  disabledHint: const Text("Can't select"),
                                  dropdownColor: Colors.white,
                                  isExpanded: true,
                                  items:
                                      category?.map((WalletBankModel category) {
                                    return DropdownMenuItem(
                                        value: category,
                                        child: Text(
                                            "${category.nameBank} - ${category.walletData.price}",
                                            overflow: TextOverflow.fade));
                                  }).toList(),
                                  onChanged: (newValue) {
                                    walletFrom = newValue;
                                  },
                                  value: walletFrom,
                                  hint: TextStyles.body2(text: "Select wallet"),
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
                                  ),
                                );
                              }
                              return const SizedBox();
                            },
                          ),
                        ),
                        SizedBox(
                          width: 5.w,
                        ),
                        Expanded(
                          flex: 1,
                          child: Container(
                            width: 50.w,
                            height: 50.h,
                            padding: const EdgeInsets.all(8),
                            decoration: BoxDecoration(
                                border: Border.all(color: ColorName.textGrey),
                                shape: BoxShape.circle,
                                color: ColorName.whiteBackground),
                            child: Assets.images.icons.transactionFab.svg(),
                          ),
                        ),
                        SizedBox(
                          width: 5.w,
                        ),
                        Expanded(
                          flex: 3,
                          child: BlocBuilder<TransferCubit, TransferState>(
                            builder: (context, state) {
                              final status = state.listWallet.status;
                              if (status.isHasData) {
                                final category = state.listWallet.data;
                                return DropdownButtonFormField(
                                  disabledHint: const Text("Can't select"),
                                  dropdownColor: Colors.white,
                                  isExpanded: true,
                                  items:
                                      category?.map((WalletBankModel category) {
                                    return DropdownMenuItem(
                                        value: category,
                                        child: Text(
                                            "${category.nameBank} - ${category.walletData.price}",
                                            overflow: TextOverflow.fade));
                                  }).toList(),
                                  onChanged: (newValue) {
                                    walletTo = newValue;
                                  },
                                  value: walletTo,
                                  hint: TextStyles.body2(text: "Select wallet"),
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
                                  ),
                                );
                              }
                              return const SizedBox();
                            },
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 16.h,
                    ),
                    TextFieldCustom.textFieldNormal(
                        controller: textEditingControllerDescription,
                        hint: "Description",
                        validator: (val) {
                          if (val!.isEmpty) {
                            return 'Name is empty';
                          }
                          return null;
                        },
                        onTap: () {
                          // Scrollable.ensureVisible(_nameFormKey.currentContext!);
                        }),
                    SizedBox(
                      height: 16.h,
                    ),
                    TextFieldCustom.textFieldNormal(
                        controller: textEditingControllerOtherCost,
                        hint: "Other cost",
                        inputFormatters: [
                          CurrencyTextInputFormatter.currency(
                              locale: 'id', symbol: "", decimalDigits: 0)
                        ],
                        validator: (val) {
                          if (val!.isEmpty) {
                            return 'Name is empty';
                          }
                          return null;
                        },
                        onTap: () {
                          // Scrollable.ensureVisible(_nameFormKey.currentContext!);
                        }),
                    SizedBox(
                      height: 16.h,
                    ),
                    BlocBuilder<TransferCubit, TransferState>(
                        builder: (context, state) {
                      final status = state.imageFile.status;
                      if (status.isHasData) {
                        final imgFile = state.imageFile.data;
                        return Align(
                          alignment: Alignment.topLeft,
                          child: Stack(
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(15.0),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(9),
                                  child: Image.file(
                                    imgFile!,
                                    width: 112.w,
                                    height: 112.h,
                                    fit: BoxFit.fill,
                                  ),
                                ),
                              ),
                              Positioned(
                                left: 125,
                                top: 5,
                                child: InkWell(
                                  onTap: () {
                                    context.read<TransferCubit>().clearImage();
                                  },
                                  child: Assets.images.icons.close.svg(),
                                ),
                              ),
                            ],
                          ),
                        );
                      }
                      if (status.isInitial || status.isNoData) {
                        return Material(
                          child: InkWell(
                            borderRadius: BorderRadius.circular(20.r),
                            splashColor: ColorName.bacgroundRedIcon,
                            onTap: () {
                              ModalBottom.modalBottomSheetAttachment(
                                context: context,
                                onTapCamera: () async {
                                  await availableCameras().then((value) =>
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (_) =>
                                                  CameraPage(cameras: value))));
                                },
                                onTapImage: () {
                                  context.read<TransferCubit>().openImage();
                                  Navigator.pop(context);
                                },
                                onTapDocument: () {},
                              );
                            },
                            child: DottedBorder(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 16, vertical: 10),
                                borderType: BorderType.RRect,
                                radius: const Radius.circular(20),
                                dashPattern: const [10, 10],
                                color: Colors.grey,
                                strokeWidth: 2,
                                child: SizedBox(
                                  height: 40.h,
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Image.asset(
                                        Assets.images.picture.paperclip.path,
                                        width: 25.w,
                                        height: 25.h,
                                      ),
                                      SizedBox(
                                        width: 10.w,
                                      ),
                                      TextStyles.body2(
                                          text: "Add attachment",
                                          color: ColorName.textGrey)
                                    ],
                                  ),
                                )),
                          ),
                        );
                      }
                      return const SizedBox();
                    }),
                    SizedBox(
                      height: 20.h,
                    ),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: TextStyles.body2(text: "Date Transaction"),
                    ),
                    SizedBox(
                      height: 5.h,
                    ),
                    DatePickerCustom(
                      restorationId: 'expanseId',
                      selectedDate: _selectedDate,
                      selectDate: _selectDate,
                    )
                  ],
                ),
              ),
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
            label: "Continue",
            onTap: () {
              if (textEditingControllerBalance.text.isEmpty) {
                showTopSnackBar(
                  Overlay.of(context),
                  const CustomSnackBar.error(
                    message: "Price is empty",
                  ),
                );
              } else if (int.parse(
                      textEditingControllerBalance.text.replaceAll(".", "") ??
                          "0") >
                  (walletFrom!.walletData.price)) {
                showTopSnackBar(
                  Overlay.of(context),
                  const CustomSnackBar.error(
                    message: "price is greater than the current wallet",
                  ),
                );
              } else if (walletFrom!.walletData.idBank ==
                  walletTo!.walletData.idBank) {
                showTopSnackBar(
                  Overlay.of(context),
                  const CustomSnackBar.error(
                    message: "Wallet is same",
                  ),
                );
              } else {
                context.read<TransferCubit>().insertWallet(
                      walletFrom: walletFrom!.walletData,
                      walletTo: walletTo!.walletData,
                      price: textEditingControllerBalance.text,
                      otherCost: textEditingControllerOtherCost.text,
                      description: textEditingControllerDescription.text,
                      dateNow: _selectedDate.value,
                    );
              }
            },
          ),
        ),
      ),
    );
  }
}
