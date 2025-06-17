part of 'budget_cubit.dart';

class BudgetState extends Equatable {
  final ViewData<String> month;
  final ViewData<int> intMonth;
  final ViewData<int> insertBudget;
  final ViewData<bool> isNotice;
  final ViewData<List<CategoryTransactionEntity>> listCategory;
  final ViewData<List<BudgetEntity>> listBudget;
  final ViewData<int> updateBudget;
  final ViewData<int> deleteBudget;

  BudgetState({
    required this.month,
    required this.intMonth,
    required this.listCategory,
    required this.insertBudget,
    required this.isNotice,
    required this.listBudget,
    required this.updateBudget,
    required this.deleteBudget,
  });

  BudgetState copyWith({
    ViewData<String>? month,
    ViewData<int>? intMonth,
    ViewData<List<CategoryTransactionEntity>>? listCategory,
    ViewData<int>? insertBudget,
    ViewData<bool>? isNotice,
    ViewData<List<BudgetEntity>>? listBudget,
    ViewData<int>? updateBudget,
    ViewData<int>? deleteBudget,
  }) {
    return BudgetState(
        month: month ?? this.month,
        intMonth: intMonth ?? this.intMonth,
        listCategory: listCategory ?? this.listCategory,
        insertBudget: insertBudget ?? this.insertBudget,
        isNotice: isNotice ?? this.isNotice,
        listBudget: listBudget ?? this.listBudget,
        updateBudget: updateBudget ?? this.updateBudget,
        deleteBudget: deleteBudget ?? this.deleteBudget,
    );
  }

  @override
  List<Object> get props => [
        month,
        intMonth,
        listCategory,
        insertBudget,
        isNotice,
        listBudget,
        updateBudget,
        deleteBudget
      ];
}
