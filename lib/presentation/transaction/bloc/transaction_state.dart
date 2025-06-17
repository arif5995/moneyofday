part of 'transaction_cubit.dart';

class TransactionState extends Equatable {
  final ViewData<List<TransactionEntity>> listTransaction;

  const TransactionState({required this.listTransaction});

  TransactionState copyWith(
      {ViewData<List<TransactionEntity>>? listTransaction}) {
    return TransactionState(
        listTransaction: listTransaction ?? this.listTransaction);
  }

  @override
  List<Object> get props => [listTransaction];
}
