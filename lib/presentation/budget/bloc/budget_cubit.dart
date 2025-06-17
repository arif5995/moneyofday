import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:monday/domain/entities/budget_entity.dart';
import 'package:monday/domain/entities/category_transaction_entity.dart';
import 'package:monday/domain/usecase/delete_budget_usecase.dart';
import 'package:monday/domain/usecase/get_budget_permonth_usecase.dart';
import 'package:monday/domain/usecase/get_category_transaction_usecase.dart';
import 'package:monday/domain/usecase/get_transaction_by_idCategory_usecase.dart';
import 'package:monday/domain/usecase/insert_budget_usecase.dart';
import 'package:monday/domain/usecase/update_budget_usecase.dart';
import 'package:monday/utils/constant/app_constant.dart';
import 'package:monday/utils/date/date_month.dart';
import 'package:monday/utils/error/failure_response.dart';
import 'package:monday/utils/state/view_data_state.dart';
import 'package:monday/utils/usecase/use_case.dart';

part 'budget_state.dart';

class BudgetCubit extends Cubit<BudgetState> {
  final GetCategoryTransactionUseCase getCategoryTransactionUseCase;
  final InsertBudgetUseCase insertBudgetUseCase;
  final GetBudgetPerMonthUseCase getBudgetPerMonthUseCase;
  final GetTransactionByIdCategoryUseCase getTransactionByIdCategoryUseCase;
  final UpdateBudgetUseCase updateBudgetUseCase;
  final DeleteBudgetUseCase deleteBudgetUseCase;

  BudgetCubit({
    required this.getCategoryTransactionUseCase,
    required this.insertBudgetUseCase,
    required this.getBudgetPerMonthUseCase,
    required this.getTransactionByIdCategoryUseCase,
    required this.updateBudgetUseCase,
    required this.deleteBudgetUseCase,
  }) : super(
          BudgetState(
            month: ViewData.initial(),
            intMonth: ViewData.initial(),
            listCategory: ViewData.initial(),
            insertBudget: ViewData.initial(),
            isNotice: ViewData.loaded(data: false),
            listBudget: ViewData.initial(),
            updateBudget: ViewData.initial(),
            deleteBudget: ViewData.initial(),
          ),
        );

  void initiateMonth() async {
    try {
      var allMonth = Date.month;
      int currentMonth = DateTime.now().month;
      String month = allMonth[currentMonth - 1]["name"];

      final result = await getBudgetPerMonthUseCase.call(currentMonth);

      result.fold(
          (error) => emit(
                state.copyWith(
                  listBudget: ViewData.error(
                    message: "Get Data Budget Error",
                    failure: FailureResponse(
                      errorMessage: error.errorMessage,
                    ),
                  ),
                ),
              ), (data) async {
        if (data.isEmpty) {
          emit(
            state.copyWith(
              listBudget: ViewData.noData(message: "Data Budget Kosong"),
            ),
          );
        } else {
          List<Map<dynamic, String>> dataMap = [];
          final listBudget = <BudgetEntity>[];
          // data.reduce((value, element) => value.);
          // data.sort((a,b)=>a.idCategory.compareTo(b.idCategory),);
          int totalShopping = 0;
          int totalSubscription = 0;
          int totalTransportation = 0;
          int totalFood = 0;
          int totalTransfer = 0;
          for (var item in data) {
            if (item.idCategory == 1) {
              final transaction = await getTransactionByIdCategoryUseCase
                  .call([item.idCategory, currentMonth]);

              transaction.fold((l) => null, (data) {
                for (var element in data) {
                  totalShopping += int.parse(element.price);
                }
              });
              listBudget.add(
                BudgetEntity(
                    id: item.id,
                    idCategory: item.idCategory,
                    price: item.price,
                    categoryName: item.categoryName,
                    isNotice: item.isNotice,
                    priceCategory: totalShopping.toString(),
                    dateTime: item.dateTime),
              );
              totalShopping = 0;
            } else if (item.idCategory == 2) {
              final transaction = await getTransactionByIdCategoryUseCase
                  .call([item.idCategory, currentMonth]);
              transaction.fold((l) => null, (data) {
                for (var element in data) {
                  totalSubscription += int.parse(element.price);
                }
              });
              listBudget.add(
                BudgetEntity(
                    id: item.id,
                    idCategory: item.idCategory,
                    price: item.price,
                    categoryName: item.categoryName,
                    isNotice: item.isNotice,
                    priceCategory: totalSubscription.toString(),
                    dateTime: item.dateTime),
              );
              totalSubscription = 0;
            } else if (item.idCategory == 3) {
              final transaction = await getTransactionByIdCategoryUseCase
                  .call([item.idCategory, currentMonth]);
              transaction.fold((l) => null, (data) {
                for (var element in data) {
                  totalTransportation += int.parse(element.price);
                }
              });
              listBudget.add(
                BudgetEntity(
                    id: item.id,
                    idCategory: item.idCategory,
                    price: item.price,
                    categoryName: item.categoryName,
                    isNotice: item.isNotice,
                    priceCategory: totalTransportation.toString(),
                    dateTime: item.dateTime),
              );
              totalTransportation = 0;
            } else if (item.idCategory == 4) {
              final transaction = await getTransactionByIdCategoryUseCase
                  .call([item.idCategory, currentMonth]);
              transaction.fold((l) => null, (data) {
                for (var element in data) {
                  totalFood += int.parse(element.price);
                }
              });
              listBudget.add(
                BudgetEntity(
                    id: item.id,
                    idCategory: item.idCategory,
                    price: item.price,
                    categoryName: item.categoryName,
                    isNotice: item.isNotice,
                    priceCategory: totalFood.toString(),
                    dateTime: item.dateTime),
              );
              totalFood = 0;
            } else {
              final transaction = await getTransactionByIdCategoryUseCase
                  .call([item.idCategory, currentMonth]);
              transaction.fold((l) => null, (data) {
                for (var element in data) {
                  totalTransfer += int.parse(element.price);
                }
              });
              listBudget.add(
                BudgetEntity(
                    id: item.id,
                    idCategory: item.idCategory,
                    price: item.price,
                    categoryName: item.categoryName,
                    isNotice: item.isNotice,
                    priceCategory: totalTransfer.toString(),
                    dateTime: item.dateTime),
              );
              totalTransfer = 0;
            }
          }
          emit(
            state.copyWith(
              listBudget: ViewData.loaded(data: listBudget),
            ),
          );
        }
      });

      emit(state.copyWith(intMonth: ViewData.loaded(data: currentMonth - 1)));
      emit(state.copyWith(month: ViewData.loaded(data: month)));
    } catch (e) {
      emit(
        state.copyWith(
          listBudget: ViewData.error(
            message: "Exception Get Budget",
            failure: FailureResponse(
              errorMessage: e.toString(),
            ),
          ),
        ),
      );
    }
  }

  void leftMonth() async {
    try {
      final intMonth = state.intMonth.data;
      var allMonth = Date.month;
      String month = allMonth[(intMonth ?? 0) - 1]["name"];

      final result = await getBudgetPerMonthUseCase.call(intMonth ?? 0);

      result.fold(
          (error) => emit(
                state.copyWith(
                  listBudget: ViewData.error(
                    message: "Get Data Budget Error",
                    failure: FailureResponse(
                      errorMessage: error.errorMessage,
                    ),
                  ),
                ),
              ), (data) {
        if (data.isEmpty) {
          emit(
            state.copyWith(
              listBudget: ViewData.noData(message: "Data Budget Kosong"),
            ),
          );
        } else {
          emit(
            state.copyWith(
              listBudget: ViewData.loaded(data: data),
            ),
          );
        }
      });

      emit(
          state.copyWith(intMonth: ViewData.loaded(data: (intMonth ?? 0) - 1)));
      emit(state.copyWith(month: ViewData.loaded(data: month)));
    } catch (e) {
      emit(
        state.copyWith(
          listBudget: ViewData.error(
            message: "Exception Get Budget",
            failure: FailureResponse(
              errorMessage: e.toString(),
            ),
          ),
        ),
      );
    }
  }

  void rightMonth() async {
    try {
      final intMonth = state.intMonth.data;
      var allMonth = Date.month;
      String month = allMonth[(intMonth ?? 0) + 1]["name"];

      final result = await getBudgetPerMonthUseCase.call(intMonth ?? 0);

      result.fold(
          (error) => emit(
                state.copyWith(
                  listBudget: ViewData.error(
                    message: "Get Data Budget Error",
                    failure: FailureResponse(
                      errorMessage: error.errorMessage,
                    ),
                  ),
                ),
              ), (data) {
        if (data.isEmpty) {
          emit(
            state.copyWith(
              listBudget: ViewData.noData(message: "Data Budget Kosong"),
            ),
          );
        } else {
          emit(
            state.copyWith(
              listBudget: ViewData.loaded(data: data),
            ),
          );
        }
      });

      emit(
          state.copyWith(intMonth: ViewData.loaded(data: (intMonth ?? 0) + 1)));
      emit(state.copyWith(month: ViewData.loaded(data: month)));
    } catch (e) {
      emit(
        state.copyWith(
          listBudget: ViewData.error(
            message: "Exception Get Budget",
            failure: FailureResponse(
              errorMessage: e.toString(),
            ),
          ),
        ),
      );
    }
  }

  void getCategory() async {
    try {
      final result = await getCategoryTransactionUseCase.call(const NoParams());

      result.fold((error) {
        emit(
          state.copyWith(
            listCategory:
                ViewData.error(message: "exception expanse", failure: error),
          ),
        );
      }, (data) {
        data.removeWhere(
            (element) => element.id == AppConstants.category.salaryId);
        emit(
          state.copyWith(listCategory: ViewData.loaded(data: data)),
        );
      });
    } catch (e) {
      emit(
        state.copyWith(
          listCategory: ViewData.error(
            message: "exception expanse",
            failure: FailureResponse(errorMessage: e.toString()),
          ),
        ),
      );
    }
  }

  void changeNotice({required bool isNotice}) {
    emit(
      state.copyWith(
        isNotice: ViewData.initial(),
      ),
    );
    emit(
      state.copyWith(
        isNotice: ViewData.loaded(data: isNotice),
      ),
    );
  }

  void insertBudget(
      {required String price,
      required CategoryTransactionEntity category}) async {
    final isNotice = state.isNotice.data;
    final budgetEntity = BudgetEntity(
        idCategory: category.id ?? 0,
        categoryName: category.name,
        isNotice: isNotice,
        price: price.replaceAll(".", ""),
        dateTime: DateTime.now());
    try {
      final data = await insertBudgetUseCase.call(budgetEntity);

      data.fold(
        (failure) => emit(
          state.copyWith(
            insertBudget: ViewData.error(
              message: failure.errorMessage,
              failure: failure,
            ),
          ),
        ),
        (data) => emit(
          state.copyWith(
            insertBudget: ViewData.loaded(data: data),
          ),
        ),
      );
    } catch (e) {
      emit(
        state.copyWith(
          insertBudget: ViewData.error(
            message: e.toString(),
            failure: FailureResponse(
              errorMessage: e.toString(),
            ),
          ),
        ),
      );
    }
  }

  void updateBudget({required BudgetEntity budgetEntity}) async {
    final isNotice = state.isNotice.data;

    final result = await updateBudgetUseCase
        .call(budgetEntity.copyWith(isNotice: isNotice));

    result.fold(
      (failure) => emit(
        state.copyWith(
          updateBudget: ViewData.error(
            message: "Failed exception update budget",
            failure: failure,
          ),
        ),
      ),
      (data) {
        if (data > 0) {
          emit(
            state.copyWith(
              updateBudget: ViewData.loaded(data: data),
            ),
          );
        } else {
          emit(
            state.copyWith(
              updateBudget: ViewData.noData(message: "Failed update budget"),
            ),
          );
        }
      },
    );
  }

  void deleteBudget({required int idBudget}) async {
    final result = await deleteBudgetUseCase.call(idBudget);

    result.fold(
      (failure) => emit(state.copyWith(
          deleteBudget: ViewData.error(
              message: "Failed Exception Delete Budget", failure: failure))),
      (data) {
        if (data > 0) {
          emit(
            state.copyWith(
              deleteBudget: ViewData.loaded(data: data),
            ),
          );
        } else {
          emit(
            state.copyWith(
              deleteBudget: ViewData.noData(message: "Failed Delete Budget"),
            ),
          );
        }
      }
    );
  }
}
