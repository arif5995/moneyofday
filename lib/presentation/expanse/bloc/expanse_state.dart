part of 'expanse_cubit.dart';

class ExpanseState extends Equatable {
  final ViewData<List<WalletBankModel>> listWallet;
  final ViewData<String> imagePath;
  final ViewData<int> insertExpanse;
  final ViewData<File> imageFile;
  final ViewData<List<CategoryTransactionEntity>> listCategory;
  final ViewData<int> wallet;

  const ExpanseState(
      {required this.listWallet,
      required this.insertExpanse,
      required this.imagePath,
      required this.imageFile,
      required this.listCategory,
        required this.wallet});

  ExpanseState copyState({
    ViewData<List<WalletBankModel>>? listWallet,
    ViewData<int>? insertIncome,
    ViewData<String>? imagePath,
    ViewData<File>? imageFile,
    ViewData<List<CategoryTransactionEntity>>? listCategory,
    ViewData<int>? wallet
  }) {
    return ExpanseState(
        listWallet: listWallet ?? this.listWallet,
        insertExpanse: insertIncome ?? this.insertExpanse,
        imagePath: imagePath ?? this.imagePath,
        imageFile: imageFile ?? this.imageFile,
        listCategory: listCategory ?? this.listCategory,
        wallet:  wallet ?? this.wallet
    );
  }

  @override
  List<Object> get props =>
      [listWallet, imagePath, imageFile, insertExpanse, listCategory, wallet];
}
