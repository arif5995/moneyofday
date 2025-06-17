part of 'account_cubit.dart';

class AccountState extends Equatable {
  final ViewData<AccountEntity> account;
  final ViewData<List<BankEntity>> bank;
  final ViewData<bool> insertBank;
  final ViewData<int> idBank;
  final ViewData<int> accountType;
  final ViewData<bool> insertWallet;
  final ViewData<String> contentBalance;

  const AccountState(
      {required this.account,
      required this.bank,
      required this.insertBank,
      required this.contentBalance,
      required this.insertWallet,
      required this.accountType,
      required this.idBank});

  AccountState copyWith({
    ViewData<AccountEntity>? account,
    ViewData<List<BankEntity>>? bank,
    ViewData<bool>? insertBank,
    ViewData<bool>? insertWallet,
    ViewData<String>? contentBalance,
    ViewData<int>? idBank,
    ViewData<int>? accountType,
  }) {
    return AccountState(
        account: account ?? this.account,
        bank: bank ?? this.bank,
        insertBank: insertBank ?? this.insertBank,
        contentBalance: contentBalance ?? this.contentBalance,
        insertWallet: insertWallet ?? this.insertWallet,
        idBank: idBank ?? this.idBank,
        accountType: accountType ?? this.accountType);
  }

  @override
  List<Object> get props => [
        account,
        bank,
        insertBank,
        contentBalance,
        insertWallet,
        idBank,
        accountType
      ];
}
