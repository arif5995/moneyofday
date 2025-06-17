part of 'home_cubit.dart';

class HomeState extends Equatable {
  final ViewData<int> homeState;
  final ViewData<bool> isShowFab;
  final ViewData<List<DatePeriod>> tabPeriod;
  final ViewData<int> intMonth;
  final ViewData<List<dynamic>> month;
  final ViewData<List<String>> tabDate;
  final ViewData<List<TransactionEntity>> listTransaction;
  final ViewData<int> totalIncome;
  final ViewData<int> totalExpanse;
  final ViewData<int> accountBalance;
  final ViewData<List<FlSpot>> listFlSpotIncome;
  final ViewData<List<FlSpot>> listFlSpotExpanse;

  const HomeState({
    required this.isShowFab,
    required this.homeState,
    required this.tabPeriod,
    required this.intMonth,
    required this.month,
    required this.tabDate,
    required this.listTransaction,
    required this.totalIncome,
    required this.totalExpanse,
    required this.accountBalance,
    required this.listFlSpotIncome,
    required this.listFlSpotExpanse
  });

  HomeState copyWith({
    ViewData<int>? homeState,
    ViewData<bool>? isShowFab,
    ViewData<List<DatePeriod>>? tabPeriod,
    ViewData<int>? intMonth,
    ViewData<List<dynamic>>? month,
    ViewData<List<String>>? tabDate,
    ViewData<List<TransactionEntity>>? listTransaction,
    ViewData<int>? totalIncome,
    ViewData<int>? totalExpanse,
    ViewData<int>? accountBalance,
    ViewData<List<FlSpot>>? listFlSpotIncome,
    ViewData<List<FlSpot>>? listFlSpotExpanse,
  }) {
    return HomeState(
        homeState: homeState ?? this.homeState,
        isShowFab: isShowFab ?? this.isShowFab,
        tabPeriod: tabPeriod ?? this.tabPeriod,
        intMonth: intMonth ?? this.intMonth,
        month: month ?? this.month,
        tabDate: tabDate ?? this.tabDate,
        listTransaction: listTransaction ?? this.listTransaction,
        totalIncome: totalIncome ?? this.totalIncome,
        totalExpanse: totalExpanse ?? this.totalExpanse,
        accountBalance: accountBalance ?? this.accountBalance,
        listFlSpotExpanse: listFlSpotExpanse ?? this.listFlSpotExpanse,
        listFlSpotIncome: listFlSpotIncome ?? this.listFlSpotIncome
    );
  }

  @override
  List<Object> get props => [
        homeState,
        isShowFab,
        tabPeriod,
        intMonth,
        month,
        tabDate,
        listTransaction,
        totalIncome,
        totalExpanse,
        accountBalance,
        listFlSpotIncome,
        listFlSpotExpanse
      ];
}
