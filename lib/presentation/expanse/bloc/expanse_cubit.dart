import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:drift/drift.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/services.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:image_picker/image_picker.dart';
import 'package:monday/datasource/local/database_impl.dart';
import 'package:monday/datasource/model/wallet_bank_model.dart';
import 'package:monday/domain/entities/category_transaction_entity.dart';
import 'package:monday/domain/usecase/get_category_transaction_usecase.dart';
import 'package:monday/domain/usecase/get_wallet_usecase.dart';
import 'package:monday/domain/usecase/insert_transaction_usecase.dart';
import 'package:monday/domain/usecase/update_wallet_usecase.dart';
import 'package:monday/utils/constant/app_constant.dart';
import 'package:monday/utils/error/failure_response.dart';
import 'package:monday/utils/state/view_data_state.dart';
import 'package:monday/utils/usecase/use_case.dart';
import 'package:path/path.dart';

part 'expanse_state.dart';

class ExpanseCubit extends Cubit<ExpanseState> {
  final GetWalletUseCase getWalletUsecase;
  final InsertTransactionUseCase insertTransactionUseCase;
  final UpdateWalletUseCase updateWalletUseCase;
  final ImagePicker imagePicker;
  final GetCategoryTransactionUseCase getCategoryTransactionUseCase;

  ExpanseCubit(
      {required this.getWalletUsecase,
      required this.insertTransactionUseCase,
      required this.imagePicker,
      required this.getCategoryTransactionUseCase,
      required this.updateWalletUseCase})
      : super(
          ExpanseState(
            listWallet: ViewData.initial(),
            imagePath: ViewData.initial(),
            imageFile: ViewData.initial(),
            insertExpanse: ViewData.initial(),
            listCategory: ViewData.initial(),
            wallet: ViewData.initial()
          ),
        );

  void getWalletData() async {
    try {
      final data = await getWalletUsecase.call(const NoParams());
      data.fold(
          (error) => emit(
                state.copyState(
                  listWallet: ViewData.error(
                    message: error.errorMessage,
                    failure: FailureResponse(errorMessage: error.errorMessage),
                  ),
                ),
              ), (dataWallet) {
        emit(
          state.copyState(
            listWallet: ViewData.loaded(data: dataWallet),
          ),
        );
      });
    } catch (error) {
      emit(
        state.copyState(
          listWallet: ViewData.error(
            message: "Get Data Wallet Error",
            failure: const FailureResponse(errorMessage: "exception"),
          ),
        ),
      );
    }
  }

  void openImage() async {
    try {
      final pickedFile =
          await imagePicker.pickImage(source: ImageSource.gallery);
      if (pickedFile != null) {
        emit(
          state.copyState(
            imagePath: ViewData.loaded(
              data: pickedFile.path,
            ),
          ),
        );
        emit(
          state.copyState(
            imageFile: ViewData.loaded(
              data: File(pickedFile.path),
            ),
          ),
        );
      } else {
        emit(
          state.copyState(
            imagePath: ViewData.noData(message: "No Image is selected"),
          ),
        );
      }
    } catch (e) {
      emit(
        state.copyState(
          imagePath: ViewData.error(
            message: "Error exception get picked",
            failure: FailureResponse(
              errorMessage: e.toString(),
            ),
          ),
        ),
      );
    }
  }

  void clearImage() async {
    emit(
      state.copyState(
          imagePath: ViewData.noData(message: "successfully deleted")),
    );

    emit(
      state.copyState(
          imageFile: ViewData.noData(message: "successfully deleted")),
    );
  }

  void getCategoryTransaction() async {
    try {
      final result = await getCategoryTransactionUseCase.call(const NoParams());

      result.fold((error) {
        emit(
          state.copyState(
            listCategory:
                ViewData.error(message: "exception expanse", failure: error),
          ),
        );
      }, (data) {
        data.removeWhere((element) => element.id == AppConstants.category.salaryId);
        emit(
          state.copyState(listCategory: ViewData.loaded(data: data)),
        );
      });
    } catch (e) {
      emit(
        state.copyState(
          listCategory: ViewData.error(
            message: "exception expanse",
            failure: FailureResponse(errorMessage: e.toString()),
          ),
        ),
      );
    }
  }

  void insertExpanse(
      {required String price,
      required DateTime dateNow,
      required CategoryTransactionEntity category,
      required WalletBankModel walletBank,
      String? description}) async {
    final idTransactionType = AppConstants.transaction.expanse;
    final imageFile = state.imageFile.data;
    final imagePath = state.imagePath.data;
    final balance = int.parse(price.replaceAll(".", ""));

    try {
      if (imageFile != null) {
        String baseName = basename(imageFile.path);
        Uint8List bytes = await imageFile.readAsBytes();
        await ImageGallerySaver.saveImage(bytes,
            isReturnImagePathOfIOS: true, quality: 60, name: baseName);
        // if(result["isSuccess"] == true){
        //   isImage = true;
        //   print("Image saved successfully.");
        // }else{
        //   isImage = false;
        //   print(result["errorMessage"]);
        // }
      }

      final dataFrom = WalletData(
          id: walletBank.walletData.id,
          name: walletBank.walletData.name,
          idBank: walletBank.walletData.idBank,
          price: walletBank.walletData.price - balance,
          accountType: walletBank.walletData.accountType,
          createDate: dateNow);

      final params = TransactionsCompanion.insert(
          idTransaction: idTransactionType,
          idCategory: category.id ?? 0,
          idWallet: walletBank.walletData.idBank,
          description: Value(description),
          price: price.replaceAll(".", ""),
          pathImg: Value(imagePath),
          createDate: dateNow);

      final resultWallet = await updateWalletUseCase.call(dataFrom);
      final result = await insertTransactionUseCase.call(params);

      resultWallet.fold(
            (failure) {
          emit(
            state.copyState(
              wallet: ViewData.error(
                message: "Insert wallet form is an failed",
                failure: FailureResponse(
                  errorMessage: failure.toString(),
                ),
              ),
            ),
          );
        },
            (data) => emit(
          state.copyState(
            wallet: ViewData.loaded(data: 1),
          ),
        ),
      );

      result.fold((failure) => emit(
        state.copyState(
          imagePath: ViewData.error(
            message: "Insert transaction is an failed",
            failure: FailureResponse(
              errorMessage: failure.toString(),
            ),
          ),
        ),
      ), (data) {
        emit(
          state.copyState(
            insertIncome: ViewData.loaded(data: data),
          ),
        );
      });
    } catch (e) {
      emit(
        state.copyState(
          insertIncome: ViewData.error(
            message: "Error exception $e",
            failure: FailureResponse(
              errorMessage: e.toString(),
            ),
          ),
        ),
      );
    }
  }
}
