import 'package:drift/drift.dart';

class Wallet extends Table{
  IntColumn get id => integer().autoIncrement().nullable()();
  Column get name => text().named("name")();
  IntColumn get idBank => integer().named("id_bank")();
  IntColumn get price => integer()();
  TextColumn get accountType => text()();
  DateTimeColumn get createDate => dateTime().named("create_date")();
}