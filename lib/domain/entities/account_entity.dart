class AccountEntity {
  final String? id;
  final String price;
  final String name;
  final String type;
  final String idBank;

  AccountEntity(
      {this.id,
      required this.price,
      required this.name,
      required this.type,
      required this.idBank});
}
