part of 'income_cubit.dart';

class IncomeState extends Equatable {
  final ViewData<List<WalletBankModel>> listWallet;
  final ViewData<String> imagePath;
  final ViewData<int> insertIncome;
  final ViewData<File> imageFile;
  final ViewData<int> wallet;

  const IncomeState(
      {required this.listWallet,
      required this.insertIncome,
      required this.imagePath,
      required this.imageFile,
      required this.wallet});

  IncomeState copyState(
      {ViewData<List<WalletBankModel>>? listWallet,
      ViewData<int>? insertIncome,
      ViewData<String>? imagePath,
      ViewData<File>? imageFile,
      ViewData<int>? wallet}) {
    return IncomeState(
        listWallet: listWallet ?? this.listWallet,
        insertIncome: insertIncome ?? this.insertIncome,
        imagePath: imagePath ?? this.imagePath,
        imageFile: imageFile ?? this.imageFile,
        wallet: wallet ?? this.wallet);
  }

  @override
  List<Object> get props =>
      [listWallet, imagePath, imageFile, insertIncome, wallet];
}
