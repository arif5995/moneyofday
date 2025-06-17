import 'package:drift/drift.dart';

class Transactions extends Table{
  IntColumn get id => integer().autoIncrement()();
  IntColumn get idTransaction => integer()();
  IntColumn get idCategory => integer()();
  IntColumn get idWallet => integer()();
  TextColumn get description => text().nullable()();
  TextColumn get pathImg => text().nullable()();
  IntColumn get idWalletFrom => integer().nullable()();
  IntColumn get idWalletTo => integer().nullable()();
  TextColumn get price => text()();
  DateTimeColumn get createDate => dateTime().named("create_date")();
}