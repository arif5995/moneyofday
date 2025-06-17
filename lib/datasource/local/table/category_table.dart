import 'package:drift/drift.dart';

@DataClassName("Category_transaction")
class CategoryTransaction extends Table {
  IntColumn get id => integer().autoIncrement()();

  TextColumn get name => text()();

}
