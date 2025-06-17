class BankEntity {
  final String? idBank;
  final String image;
  final String name;
  bool? enable;

  BankEntity(
      { this.idBank,
      required this.image,
      required this.name,
      this.enable = false});

  BankEntity copyWith({
    String? idBank,
    String? image,
    String? name,
    bool? enable,
  }) {
    return BankEntity(
        idBank: idBank ?? this.idBank,
        image: image ?? this.image,
        name: name ?? this.image,
        enable: enable ?? this.enable);
  }
}
