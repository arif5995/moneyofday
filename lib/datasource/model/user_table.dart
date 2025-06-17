class UserTable {
  final int id;
  final String name;
  final String photo;

  UserTable({required this.id, required this.name, required this.photo});

  factory UserTable.fromJson(Map<String, dynamic> json) =>
      UserTable(id: json['id'], name: json['name'], photo: json['photo']);
}