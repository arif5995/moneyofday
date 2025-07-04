
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:monday/datasource/local/database_impl.dart';
import 'package:monday/domain/entities/account_entity.dart';
import 'package:monday/domain/entities/bank_entity.dart';
import 'package:monday/domain/usecase/cache_onboarding_usecase.dart';
import 'package:monday/domain/usecase/get_bank_usecase.dart';
import 'package:monday/domain/usecase/insert_bank.dart';
import 'package:monday/domain/usecase/insert_wallet_usecase.dart';
import 'package:monday/utils/constant/app_constant.dart';
import 'package:monday/utils/error/failure_response.dart';
import 'package:monday/utils/gen/assets.gen.dart';
import 'package:monday/utils/state/view_data_state.dart';
import 'package:monday/utils/usecase/use_case.dart';

part 'account_state.dart';

class AccountCubit extends Cubit<AccountState> {
  final InsertBankUseCase insertBankUseCase;
  final GetBankUseCase getBankUseCase;
  final InsertWalletUseCase insertWalletUseCase;
  final CacheOnboardingUseCase cacheOnboardingUseCase;

  AccountCubit(
      {required this.insertBankUseCase,
      required this.getBankUseCase,
      required this.insertWalletUseCase,
      required this.cacheOnboardingUseCase})
      : super(
          AccountState(
              account: ViewData.initial(),
              bank: ViewData.initial(),
              insertBank: ViewData.initial(),
              contentBalance: ViewData.initial(),
              insertWallet: ViewData.initial(),
              idBank: ViewData.initial(),
              accountType: ViewData.initial()),
        );

  void initiateAccountType({required String accType}) async {
    try {
      if (accType == "Bank") {
        final data = await getBankUseCase.call(const NoParams());
        data.fold(
            (error) => emit(
                  state.copyWith(
                    insertBank: ViewData.error(
                      message: error.toString(),
                      failure: FailureResponse(
                        errorMessage: error.toString(),
                      ),
                    ),
                  ),
                ), (data) {
          final listBankStatic = <BankEntity>[];
          listBankStatic.addAll(data);
          listBankStatic.add(BankEntity(idBank: "0", image: "", name: ""));
          emit(
            state.copyWith(
                bank: ViewData.loaded(data: listBankStatic),
                accountType:
                    ViewData.loaded(data: AppConstants.accountType.bank)),
          );
        });
      } else {
        emit(
          state.copyWith(
            bank: ViewData.initial(),
            accountType: ViewData.loaded(data: AppConstants.accountType.wallet),
          ),
        );
      }
    } catch (e) {
      emit(
        state.copyWith(
          insertBank: ViewData.error(
            message: e.toString(),
            failure: FailureResponse(
              errorMessage: e.toString(),
            ),
          ),
        ),
      );
    }
  }

  void checkingBankStatic() async {
    emit(
        state.copyWith(insertBank: ViewData.loading(message: "Proses Insert")));
    try {
      final currentBank = await getBankUseCase.call(const NoParams());
      final listBankStatic = <BankEntity>[];
      currentBank.fold((error) {
        emit(
          state.copyWith(
            insertBank: ViewData.error(
              message: error.toString(),
              failure: FailureResponse(
                errorMessage: error.toString(),
              ),
            ),
          ),
        );
      }, (data) async {
        if (data.isEmpty) {
          listBankStatic.add(BankEntity(
              idBank: "2",
              image: Assets.images.icons.bankbca.path,
              name: "BCA"));
          listBankStatic.add(BankEntity(
              idBank: "3",
              image: Assets.images.icons.bankmandiri.path,
              name: "Mandiri"));
          listBankStatic.add(BankEntity(
              idBank: "4",
              image: Assets.images.icons.bankjago.path,
              name: "Jago"));
          listBankStatic.add(BankEntity(
              idBank: "5",
              image: Assets.images.icons.bankpaypall.path,
              name: "payapall"));
          await insertBankUseCase.call(listBankStatic);
          listBankStatic.add(BankEntity(idBank: "0", image: "", name: "See More"));
          emit(state.copyWith(bank: ViewData.loaded(data: listBankStatic)));
        } else {
          listBankStatic.addAll(data);
          listBankStatic.add(BankEntity(idBank: "0", image: "", name: ""));
          emit(state.copyWith(bank: ViewData.loaded(data: listBankStatic)));
        }
      });
    } catch (e) {
      emit(
        state.copyWith(
          insertBank: ViewData.error(
            message: e.toString(),
            failure: FailureResponse(
              errorMessage: e.toString(),
            ),
          ),
        ),
      );
    }
  }

  void contentBalance({required String balance}) async {
    String convert = balance.substring(4);
    emit(state.copyWith(contentBalance: ViewData.loaded(data: convert)));
  }

  void selectedBank({required String id}) {
    final listBank = state.bank.data;
    listBank?.forEach((element) {
      if (element.idBank == id) {
        element.enable = !element.enable!;
      } else {
        element.enable = false;
      }
    });

    emit(
      state.copyWith(
        bank: ViewData.initial(),
        idBank: ViewData.loaded(data: int.parse(id)),
      ),
    );
    emit(
      state.copyWith(
          bank: ViewData.loaded(data: listBank),
          idBank: ViewData.loaded(data: int.parse(id))),
    );
  }

  void insertNewWallet({required String balance, required String name}) async {
    final idBank = state.idBank.data;
    final accountType = state.accountType.data;

    emit(
      state.copyWith(
        insertWallet: ViewData.initial(),
      ),
    );

    if (balance.isEmpty) {
      emit(
        state.copyWith(
          insertWallet: ViewData.error(
            message: "Nominal is empty",
            failure: const FailureResponse(errorMessage: ""),
          ),
        ),
      );
    } else if (name.isEmpty) {
      emit(
        state.copyWith(
          insertWallet: ViewData.error(
            message: "Name is empty",
            failure: const FailureResponse(errorMessage: ""),
          ),
        ),
      );
    } else if (accountType == null) {
      emit(
        state.copyWith(
          insertWallet: ViewData.error(
            message: "Please select your account",
            failure: const FailureResponse(errorMessage: ""),
          ),
        ),
      );
    } else if (accountType > 0) {
      if (accountType == AppConstants.accountType.bank) {
        if (idBank == null) {
          emit(
            state.copyWith(
              insertWallet: ViewData.error(
                message: "Please select bank",
                failure: const FailureResponse(errorMessage: ""),
              ),
            ),
          );
        } else {
          emit(
            state.copyWith(
              insertWallet: ViewData.loading(),
            ),
          );
          try {
            final dataWallet = WalletCompanion.insert(
                idBank: idBank,
                price: double.parse(balance.replaceAll(".", "")).toInt(),
                accountType: accountType.toString(),
                name: name,
                createDate: DateTime.now()
            );
            final data = await insertWalletUseCase.call(dataWallet);
            data.fold(
                (error) => emit(
                      state.copyWith(
                        insertWallet: ViewData.error(
                          message: "Exception",
                          failure:
                              FailureResponse(errorMessage: error.errorMessage),
                        ),
                      ),
                    ),
                (data) async {
                  emit(
                    state.copyWith(
                      insertWallet: ViewData.loaded(data: true),
                    ),
                  );
                  await cacheOnboardingUseCase.call(const NoParams());
                });
          } catch (e) {
            emit(
              state.copyWith(
                insertWallet: ViewData.error(
                  message: "Exception",
                  failure: FailureResponse(errorMessage: e.toString()),
                ),
              ),
            );
          }
        }
      } else {
        try {
          final dataWallet = WalletCompanion.insert(
              idBank: idBank ?? 0,
              price: double.parse(balance.replaceAll(".", "")).toInt(),
              accountType: accountType.toString(),
              name: name,
              createDate: DateTime.now()
          );
          final data = await insertWalletUseCase.call(dataWallet);
          data.fold(
              (error) => emit(
                    state.copyWith(
                      insertWallet: ViewData.error(
                        message: "Exception",
                        failure:
                            FailureResponse(errorMessage: error.errorMessage),
                      ),
                    ),
                  ),
              (data) async {
                emit(
                  state.copyWith(
                    insertWallet: ViewData.loaded(data: true),
                  ),
                );
                await cacheOnboardingUseCase.call(const NoParams());
              }
              );
        } catch (e) {
          emit(
            state.copyWith(
              insertWallet: ViewData.error(
                message: "Exception",
                failure: FailureResponse(errorMessage: e.toString()),
              ),
            ),
          );
        }
      }
    }
  }
}
