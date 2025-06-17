import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:intl/intl.dart';
import 'package:monday/domain/entities/date_periode_entity.dart';
import 'package:monday/domain/entities/transaction_entity.dart';
import 'package:monday/domain/usecase/get_transaction_by_idCategory_usecase.dart';
import 'package:monday/domain/usecase/get_transaction_by_id_transaction_usecase.dart';
import 'package:monday/domain/usecase/get_transaction_usecase.dart';
import 'package:monday/domain/usecase/get_wallet_by_month_usecase.dart';
import 'package:monday/domain/usecase/get_wallet_usecase.dart';
import 'package:monday/utils/constant/app_constant.dart';
import 'package:monday/utils/date/date_month.dart';
import 'package:monday/utils/state/view_data_state.dart';
import 'package:monday/utils/usecase/use_case.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  final GetTransactionUseCase getTransactionUseCase;
  final GetWalletUseCase getWalletUsecase;
  final GetWalletByMonthUseCase getWalletByMonthUseCase;
  final GetTransactionByIdTransactionUseCase
      getTransactionByIdTransactionUseCase;

  HomeCubit(
      {required this.getTransactionUseCase,
      required this.getWalletUsecase,
      required this.getWalletByMonthUseCase,
      required this.getTransactionByIdTransactionUseCase})
      : super(
          HomeState(
              homeState: ViewData.initial(),
              isShowFab: ViewData.initial(),
              tabPeriod: ViewData.initial(),
              intMonth: ViewData.initial(),
              month: ViewData.initial(),
              tabDate: ViewData.initial(),
              listTransaction: ViewData.initial(),
              totalIncome: ViewData.initial(),
              totalExpanse: ViewData.initial(),
              accountBalance: ViewData.initial(),
              listFlSpotExpanse: ViewData.initial(),
              listFlSpotIncome: ViewData.initial()),
        );

  void changeTab({required int tabIndex}) => emit(
        state.copyWith(
          homeState: ViewData.loaded(data: tabIndex),
        ),
      );

  void showMultipleFab({required bool isShow}) => emit(
        state.copyWith(
          isShowFab: ViewData.loaded(data: isShow),
        ),
      );

  void tabPeriod({required int id}) async {
    List<DatePeriod> listDatePeriod = [];
    DateFormat dateFormat = DateFormat("yyyy-MM-dd");
    final currentDate = DateTime.now();
    final currentDay = currentDate.add(const Duration(days: 1));
    final listDate = <DateTime>[];
    final month = state.intMonth.data;
    listDatePeriod.add(
      DatePeriod(id: 1, name: "Today", tap: false),
    );
    listDatePeriod.add(
      DatePeriod(id: 2, name: "Week", tap: false),
    );
    listDatePeriod.add(
      DatePeriod(id: 3, name: "Month", tap: false),
    );
    listDatePeriod.add(
      DatePeriod(id: 4, name: "Year", tap: false),
    );
    for (var data in listDatePeriod) {
      if (data.id == id) {
        switch (data.name) {
          case "Today":
            listDate.clear();
            final day = currentDay.subtract(const Duration(days: 1));
            listDate.add(dateFormat.parse(day.toString()));
            listDate.add(dateFormat.parse(currentDay.toString()));
            break;
          case "Week":
            listDate.clear();
            final week = currentDay.subtract(const Duration(days: 7));
            listDate.add(dateFormat.parse(week.toString()));
            listDate.add(dateFormat.parse(currentDay.toString()));
            break;
          case "Month":
            listDate.clear();
            final month = currentDay.subtract(const Duration(days: 30));
            listDate.add(dateFormat.parse(month.toString()));
            listDate.add(dateFormat.parse(currentDay.toString()));
            break;
          case "Year":
            listDate.clear();
            final year = currentDay.subtract(const Duration(days: 365));
            listDate.add(dateFormat.parse(year.toString()));
            listDate.add(dateFormat.parse(currentDay.toString()));
            break;
        }
        data.tap = true;
      } else {
        data.tap = false;
      }
    }

    final result = await getTransactionUseCase.call(listDate);
    final accountBalance = await getWalletByMonthUseCase.call(month ?? 0);

    result.fold((error) {
      emit(state.copyWith(
          listTransaction: ViewData.error(message: "", failure: error)));
    }, (data) {
      emit(
        state.copyWith(
          listTransaction: ViewData.loaded(data: data),
        ),
      );
    });

    accountBalance.fold(
        (l) => emit(
              state.copyWith(
                  accountBalance: ViewData.error(
                      message: "data account tidak ada", failure: l)),
            ), (dataAccount) {
      int totalAccountBalance = 0;
      if (dataAccount.isNotEmpty) {
        for (var item in dataAccount) {
          totalAccountBalance += item.price;
        }

        emit(
          state.copyWith(
            accountBalance: ViewData.loaded(data: totalAccountBalance),
          ),
        );
      }
    });

    emit(state.copyWith(tabPeriod: ViewData.loaded(data: listDatePeriod)));
  }

  void currentMonth({int? index}) async {
    var month = Date.month;
    int currentMonth = DateTime.now().month;
    emit(state.copyWith(month: ViewData.loaded(data: month)));

    int totalIncome = 0;
    int totalExpanse = 0;
    List<FlSpot> listIncome = [];
    List<FlSpot> listExpanse = [];

    if (index != null) {
      final accountBalance = await getWalletByMonthUseCase.call(index);
      final transIncome = await getTransactionByIdTransactionUseCase
          .call([AppConstants.transaction.income, index]);
      final transExpanse = await getTransactionByIdTransactionUseCase
          .call([AppConstants.transaction.expanse, index]);

      emit(
        state.copyWith(
          intMonth: ViewData.loaded(data: index),
        ),
      );

      transIncome.fold((error) {
        emit(state.copyWith(
            listTransaction: ViewData.error(message: "", failure: error)));
      }, (data) {
        for (var element in data) {
          totalIncome += int.parse(element.price);
          listIncome.add(
            FlSpot(
              element.date.day.toDouble(),
              double.parse(element.price),
            ),
          );
        }

        emit(
          state.copyWith(
            totalIncome: ViewData.loaded(data: totalIncome),
          ),
        );

        emit(
          state.copyWith(
            listFlSpotIncome: ViewData.loaded(data: listIncome),
          ),
        );

      });

      transExpanse.fold((error) {
        emit(state.copyWith(
            listTransaction: ViewData.error(message: "", failure: error)));
      }, (data) {
        for (var element in data) {
          listExpanse.add(
            FlSpot(
              element.date.hour.toDouble(),
              double.parse(element.price),
            ),
          );
          totalExpanse += int.parse(element.price);
        }

        emit(
          state.copyWith(
            totalExpanse: ViewData.loaded(data: totalExpanse),
          ),
        );

        emit(
          state.copyWith(
            listFlSpotExpanse: ViewData.loaded(data: listExpanse),
          ),
        );
      });

      accountBalance.fold(
          (l) => emit(
                state.copyWith(
                    accountBalance: ViewData.error(
                        message: "data account tidak ada", failure: l)),
              ), (dataAccount) {
        int totalAccountBalance = 0;
        if (dataAccount.isNotEmpty) {
          for (var item in dataAccount) {
            totalAccountBalance += item.price;
          }

          emit(
            state.copyWith(
              accountBalance: ViewData.loaded(data: totalAccountBalance),
            ),
          );
        } else {
          emit(
            state.copyWith(
              accountBalance: ViewData.loaded(data: 0),
            ),
          );
        }
      });
    } else {
      final accountBalance = await getWalletByMonthUseCase.call(currentMonth);
      final transIncome = await getTransactionByIdTransactionUseCase
          .call([AppConstants.transaction.income, currentMonth]);
      final transExpanse = await getTransactionByIdTransactionUseCase
          .call([AppConstants.transaction.expanse, currentMonth]);

      emit(
        state.copyWith(
          intMonth: ViewData.loaded(data: currentMonth),
        ),
      );

      transIncome.fold((error) {
        emit(state.copyWith(
            listTransaction: ViewData.error(message: "", failure: error)));
      }, (data) {
        for (var element in data) {
          totalIncome += int.parse(element.price);
          listIncome.add(
            FlSpot(
              element.date.day.toDouble(),
              double.parse(element.price),
            ),
          );
        }

        emit(
          state.copyWith(
            totalIncome: ViewData.loaded(data: totalIncome),
          ),
        );

        emit(
          state.copyWith(
            listFlSpotIncome: ViewData.loaded(data: listIncome),
          ),
        );

      });

      transExpanse.fold((error) {
        emit(state.copyWith(
            listTransaction: ViewData.error(message: "", failure: error)));
      }, (data) {

        for (var element in data) {
          totalExpanse += int.parse(element.price);
          listExpanse.add(
            FlSpot(
              element.id.toDouble(),
              double.parse(element.price),
            ),
          );
        }

        emit(
          state.copyWith(
            totalExpanse: ViewData.loaded(data: totalExpanse),
          ),
        );

        emit(
          state.copyWith(
            listFlSpotExpanse: ViewData.loaded(data: listExpanse),
          ),
        );

      });

      accountBalance.fold(
          (l) => emit(
                state.copyWith(
                    accountBalance: ViewData.error(
                        message: "data account tidak ada", failure: l)),
              ), (dataAccount) {
        int totalAccountBalance = 0;
        if (dataAccount.isNotEmpty) {
          for (var item in dataAccount) {
            totalAccountBalance += item.price;
          }

          emit(
            state.copyWith(
              accountBalance: ViewData.loaded(data: totalAccountBalance),
            ),
          );
        } else {
          emit(
            state.copyWith(
              accountBalance: ViewData.loaded(data: 0),
            ),
          );
        }
      });
    }
  }
}
