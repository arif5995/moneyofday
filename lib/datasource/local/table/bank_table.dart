import 'package:drift/drift.dart';

class Bank extends Table{
  IntColumn get id => integer().autoIncrement()();
  TextColumn get name => text()();
  TextColumn get pathImage => text()();

}