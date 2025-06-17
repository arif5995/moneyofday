class TransactionEntity {
  final int id;
  final int idTransaction;
  final int idCategory;
  final int idWallet;
  final String? description;
  final String? pathImg;
  final int? idWalletFrom;
  final int? idWalletTo;
  final String? categoryName;
  final String? typeName;
  final String? walletName;
  final String price;
  final DateTime date;
  const TransactionEntity(
      {required this.id,
        required this.idTransaction,
        required this.idCategory,
        required this.idWallet,
        this.description,
        this.pathImg,
        this.idWalletFrom,
        this.idWalletTo,
        this.categoryName,
        this.typeName,
        this.walletName,
        required this.price,
        required this.date});

  TransactionEntity copyWith(
      {int? id,
        int? idTransaction,
        int? idCategory,
        int? idWallet,
        String? description,
        String? pathImg,
        int? idWalletFrom,
        int? idWalletTo,
        String? categoryName,
        String? typeName,
        String? walletName,
        String? price,
        DateTime? date}) =>
      TransactionEntity(
        id: id ?? this.id,
        idTransaction: idTransaction ?? this.idTransaction,
        idCategory: idCategory ?? this.idCategory,
        idWallet: idWallet ?? this.idWallet,
        description: description ?? this.description,
        pathImg: pathImg ?? this.pathImg,
        idWalletFrom:
        idWalletFrom ?? this.idWalletFrom,
        idWalletTo: idWalletTo ?? this.idWalletTo,
        categoryName: categoryName ?? this.categoryName,
        typeName: typeName ?? this.typeName,
        walletName: walletName ?? this.walletName,
        price: price ?? this.price,
        date: date ?? this.date,
      );
}
