part of 'profile_cubit.dart';

class ProfileState extends Equatable {
  final ViewData<AccountEntity> account;
  final ViewData<List<BankEntity>> bank;
  final ViewData<bool> insertBank;
  final ViewData<int> idBank;
  final ViewData<int> accountType;
  final ViewData<bool> insertWallet;
  final ViewData<String> contentBalance;
  final ViewData<List<WalletBankModel>> listWallet;
  final ViewData<List<TransactionEntity>> listTransaction;
  final ViewData<int> totalWallet;

  const ProfileState(
      {required this.account,
      required this.bank,
      required this.insertBank,
      required this.contentBalance,
      required this.insertWallet,
      required this.accountType,
      required this.idBank,
      required this.listWallet,
      required this.listTransaction,
      required this.totalWallet});

  ProfileState copyWith(
      {ViewData<AccountEntity>? account,
      ViewData<List<BankEntity>>? bank,
      ViewData<bool>? insertBank,
      ViewData<bool>? insertWallet,
      ViewData<String>? contentBalance,
      ViewData<int>? idBank,
      ViewData<int>? accountType,
      ViewData<List<WalletBankModel>>? listWallet,
      ViewData<List<TransactionEntity>>? listTransaction,
      ViewData<int>? totalWallet}) {
    return ProfileState(
        account: account ?? this.account,
        bank: bank ?? this.bank,
        insertBank: insertBank ?? this.insertBank,
        contentBalance: contentBalance ?? this.contentBalance,
        insertWallet: insertWallet ?? this.insertWallet,
        idBank: idBank ?? this.idBank,
        accountType: accountType ?? this.accountType,
        listWallet: listWallet ?? this.listWallet,
        listTransaction: listTransaction ?? this.listTransaction,
        totalWallet: totalWallet ?? this.totalWallet);
  }

  @override
  List<Object> get props => [
        account,
        bank,
        insertBank,
        contentBalance,
        insertWallet,
        idBank,
        accountType,
        listWallet,
        listTransaction,
        totalWallet
      ];
}
