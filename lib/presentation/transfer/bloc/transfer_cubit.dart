import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:drift/drift.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/services.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:image_picker/image_picker.dart';
import 'package:monday/datasource/local/database_impl.dart';
import 'package:monday/datasource/model/wallet_bank_model.dart';
import 'package:monday/domain/usecase/get_wallet_usecase.dart';
import 'package:monday/domain/usecase/insert_transaction_usecase.dart';
import 'package:monday/domain/usecase/update_wallet_usecase.dart';
import 'package:monday/utils/constant/app_constant.dart';
import 'package:monday/utils/error/failure_response.dart';
import 'package:monday/utils/state/view_data_state.dart';
import 'package:monday/utils/usecase/use_case.dart';
import 'package:path/path.dart';

part 'transfer_state.dart';

class TransferCubit extends Cubit<TransferState> {
  final GetWalletUseCase getWalletUsecase;
  final UpdateWalletUseCase updateWalletUseCase;
  final InsertTransactionUseCase insertTransactionUseCase;
  final ImagePicker imagePicker;

  TransferCubit(
      {required this.getWalletUsecase,
      required this.imagePicker,
      required this.insertTransactionUseCase,
      required this.updateWalletUseCase})
      : super(
          TransferState(
            listWallet: ViewData.initial(),
            imageFile: ViewData.initial(),
            imagePath: ViewData.initial(),
            walletForm: ViewData.initial(),
            walletTo: ViewData.initial(),
            insertTransfer: ViewData.initial(),
          ),
        );

  void getWalletFrom() async {
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

  void insertWallet(
      {required WalletData walletFrom,
      required WalletData walletTo,
      required String price,
      String? description,
      String? otherCost,
      required DateTime dateNow}) async {
    try {
      final imageFile = state.imageFile.data;
      final imagePath = state.imagePath.data;
      final balance = int.parse(price.replaceAll(".", ""));
      final addCost = int.parse(otherCost!.isNotEmpty ? otherCost.replaceAll(".", "") : "0");

      if (imageFile != null) {
        String baseName = basename(imageFile.path);
        Uint8List bytes = await imageFile.readAsBytes();
        await ImageGallerySaver.saveImage(bytes,
            isReturnImagePathOfIOS: true, quality: 60, name: baseName);
      }

      final dataFrom = WalletData(
          id: walletFrom.id,
          name: walletFrom.name,
          idBank: walletFrom.idBank,
          price: walletFrom.price - (balance + (addCost ?? 0)),
          accountType: walletFrom.accountType,
          createDate: dateNow);

      final dataTo = WalletData(
          id: walletTo.id,
          name: walletTo.name,
          idBank: walletTo.idBank,
          price: walletTo.price + balance,
          accountType: walletTo.accountType,
          createDate: dateNow
      );

      final dataTransaction = TransactionsCompanion.insert(
          idTransaction: AppConstants.transaction.transfer,
          idCategory: AppConstants.category.transferId,
          idWallet: walletTo.id ?? 0,
          price: (walletTo.price + balance).toString(),
          idWalletTo: Value(walletTo.id ?? 0),
          idWalletFrom: Value(walletFrom.id ?? 0),
          pathImg: Value(imagePath),
          createDate: dateNow);

      final resultWalletFrom = await updateWalletUseCase.call(dataFrom);
      final resultWalletTo = await updateWalletUseCase.call(dataTo);
      final resultTransfer = await insertTransactionUseCase.call(dataTransaction);

      resultWalletFrom.fold(
        (failure) {
          emit(
            state.copyState(
              walletForm: ViewData.error(
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
            walletForm: ViewData.loaded(data: 1),
          ),
        ),
      );

      resultWalletTo.fold(
        (failure) {
          emit(
            state.copyState(
              walletTo: ViewData.error(
                message: "Insert wallet to is an failed",
                failure: FailureResponse(
                  errorMessage: failure.toString(),
                ),
              ),
            ),
          );
        },
        (data) => emit(
          state.copyState(
            walletTo: ViewData.loaded(data: 1),
          ),
        ),
      );

      resultTransfer.fold(
            (failure) {
          emit(
            state.copyState(
              insertTransfer: ViewData.error(
                message: "Insert transfer is an failed",
                failure: FailureResponse(
                  errorMessage: failure.toString(),
                ),
              ),
            ),
          );
        },
            (data) => emit(
          state.copyState(
            insertTransfer: ViewData.loaded(data: 1),
          ),
        ),
      );
    } catch (e) {
      emit(
        state.copyState(
          walletTo: ViewData.error(
            message: "Error exception $e",
            failure: FailureResponse(
              errorMessage: e.toString(),
            ),
          ),
        ),
      );
      emit(
        state.copyState(
          walletForm: ViewData.error(
            message: "Error exception $e",
            failure: FailureResponse(
              errorMessage: e.toString(),
            ),
          ),
        ),
      );
      emit(
        state.copyState(
          insertTransfer: ViewData.error(
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
