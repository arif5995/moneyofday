class CategoryTransactionEntity {
  final int? id;
  final String name;

  const CategoryTransactionEntity({this.id, required this.name});

  CategoryTransactionEntity copyWith({int? id, String? name}) =>
      CategoryTransactionEntity(
        id: id ?? this.id,
        name: name ?? this.name,
      );
}
