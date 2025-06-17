part of 'transfer_cubit.dart';

class TransferState extends Equatable {
  final ViewData<List<WalletBankModel>> listWallet;
  final ViewData<String> imagePath;
  final ViewData<File> imageFile;
  final ViewData<int> walletForm;
  final ViewData<int> walletTo;
  final ViewData<int> insertTransfer;

  const TransferState(
      {required this.listWallet,
      required this.imagePath,
      required this.imageFile,
      required this.walletForm,
      required this.walletTo,
      required this.insertTransfer});

  TransferState copyState(
      {ViewData<List<WalletBankModel>>? listWallet,
      ViewData<String>? imagePath,
      ViewData<File>? imageFile,
      ViewData<int>? walletForm,
      ViewData<int>? walletTo,
      ViewData<int>? insertTransfer}) {
    return TransferState(
        listWallet: listWallet ?? this.listWallet,
        imagePath: imagePath ?? this.imagePath,
        imageFile: imageFile ?? this.imageFile,
        walletForm: walletForm ?? this.walletForm,
        walletTo: walletTo ?? this.walletTo,
        insertTransfer: insertTransfer ?? this.insertTransfer);
  }

  @override
  List<Object> get props =>
      [listWallet, imageFile, imagePath, walletForm, walletTo, insertTransfer];
}
