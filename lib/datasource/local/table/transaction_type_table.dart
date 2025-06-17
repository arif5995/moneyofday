import 'package:drift/drift.dart';

@DataClassName("Transaction_type")
class TransactionType extends Table {
  IntColumn get id => integer().autoIncrement()();

  TextColumn get name => text()();

}
