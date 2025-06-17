import 'package:camera/camera.dart';
import 'package:currency_text_input_formatter/currency_text_input_formatter.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:monday/datasource/model/wallet_bank_model.dart';
import 'package:monday/domain/entities/category_transaction_entity.dart';
import 'package:monday/injections/injections.dart';
import 'package:monday/presentation/expanse/bloc/expanse_cubit.dart';
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

class ExpanseScreen extends StatefulWidget {
  const ExpanseScreen({super.key});

  @override
  State<ExpanseScreen> createState() => _ExpanseScreenState();
}

class _ExpanseScreenState extends State<ExpanseScreen> {
  FocusNode myfocus = FocusNode();

  final AuthRouter authRouter = sl();
  WalletBankModel? walletData;
  CategoryTransactionEntity? currentCategory;

  TextEditingController textEditingControllerDescription =
      TextEditingController();
  TextEditingController textEditingControllerBalance = TextEditingController();

  final RestorableDateTime _selectedDate = RestorableDateTime(DateTime.now());

  void _selectDate(DateTime? newSelectedDate) {
    if (newSelectedDate != null) {
      setState(() {
        _selectedDate.value = newSelectedDate;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<ExpanseCubit, ExpanseState>(
      listener: (context, state) {
        final statusInsert = state.insertExpanse.status;
        if (statusInsert.isHasData) {
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
        backgroundColor: ColorName.red,
        appBar: AppBar(
          elevation: 0,
          backgroundColor: ColorName.red,
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
              TextStyles.header3(text: "Expanse", fontWeight: FontWeight.bold),
        ),
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 75.h,
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
                height: MediaQuery.of(context).size.height,
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(32.r),
                        topRight: Radius.circular(32.r)),
                    color: Colors.white),
                child: Column(
                  children: [
                    BlocBuilder<ExpanseCubit, ExpanseState>(
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
                      height: 16.h,
                    ),
                    TextFieldCustom.textFieldNormal(
                        // key: _nameFormKey,
                        controller: textEditingControllerDescription,
                        hint: "Description",
                        validator: (val) {
                          if (val!.isEmpty) {
                            return 'Name is empty';
                          }
                          return null;
                        },
                        onTap: () {}),
                    SizedBox(
                      height: 16.h,
                    ),
                    BlocBuilder<ExpanseCubit, ExpanseState>(
                      builder: (context, state) {
                        final status = state.listWallet.status;
                        if (status.isHasData) {
                          final data = state.listWallet.data;
                          return DropdownButtonFormField(
                            // key: widget.bankFormKey,
                            dropdownColor: Colors.white,
                            items: data?.map((WalletBankModel wallet) {
                              return DropdownMenuItem(
                                  value: wallet,
                                  child: Text(
                                      "${wallet.nameBank} - ${wallet.walletData.price}"));
                            }).toList(),
                            onChanged: (newValue) {
                              walletData = newValue;
                            },
                            value: walletData,
                            hint: TextStyles.body2(text: "Select wallet"),
                            validator: (val) {
                              return null;
                            },
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
                      height: 16.h,
                    ),
                    BlocBuilder<ExpanseCubit, ExpanseState>(
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
                                    context.read<ExpanseCubit>().clearImage();
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
                                  context.read<ExpanseCubit>().openImage();
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
              } else if (walletData!.walletData.price <
                  int.parse(
                      textEditingControllerBalance.text.split('.').join(""))){
                showTopSnackBar(
                  Overlay.of(context),
                  const CustomSnackBar.error(
                    message: "Bigger price",
                  ),
                );
              }else {
                context.read<ExpanseCubit>().insertExpanse(
                    price: textEditingControllerBalance.text,
                    description: textEditingControllerDescription.text,
                    dateNow: _selectedDate.value,
                    category: currentCategory!,
                    walletBank: walletData!);
              }
            },
          ),
        ),
      ),
    );
  }
}
