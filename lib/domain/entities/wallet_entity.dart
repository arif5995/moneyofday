class WalletEntity {
  final int? id;
  final String name;
  final int idBank;
  final int price;
  final String accountType;
  final DateTime date;

  WalletEntity(
      {this.id,
        required this.name,
      required this.idBank,
      required this.price,
      required this.accountType,
      required this.date});

  WalletEntity copyWith(
      {
        int? id,
        String? name,
        int? idBank,
        int? price,
        String? accountType,
        DateTime? date
      }) =>
      WalletEntity(
        id: id ?? this.id,
        name: name ?? this.name,
        idBank: idBank ?? this.idBank,
        price: price ?? this.price,
        accountType: accountType ?? this.accountType,
        date: date ?? this.date
      );
}
