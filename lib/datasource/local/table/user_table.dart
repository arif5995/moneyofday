import 'package:drift/drift.dart';

class User extends Table {
  IntColumn get id => integer().autoIncrement().nullable()();
  TextColumn get name => text().withLength(min: 6, max: 32)();
  TextColumn get photo => text()();

}