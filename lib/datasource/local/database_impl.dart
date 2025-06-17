import 'package:drift/drift.dart';
import 'dart:io';
import 'package:drift/native.dart';
import 'package:monday/datasource/local/table/bank_table.dart';
import 'package:monday/datasource/local/table/budget_table.dart';
import 'package:monday/datasource/local/table/category_table.dart';
import 'package:monday/datasource/local/table/transaction_table.dart';
import 'package:monday/datasource/local/table/transaction_type_table.dart';
import 'package:monday/datasource/local/table/wallet_tablet.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as p;
import 'package:monday/datasource/local/table/user_table.dart';

part 'database_impl.g.dart';

@DriftDatabase(tables: [User, Bank, Wallet, Transactions, CategoryTransaction, TransactionType, Budget])
class DatabaseImpl extends _$DatabaseImpl {
  DatabaseImpl() : super(_openConnection());

  @override
  int get schemaVersion => 1; //

  @override
  // TODO: implement migration
  MigrationStrategy get migration {
    final listTable = <Table>[User(), Bank()];
    return MigrationStrategy(
      onCreate: (Migrator m) async {
        await m.createAll();
      },
      onUpgrade: (Migrator m, int from, int to) async {
        if (from < listTable.length) {
          await m.createTable(bank);
        }
      },
    );
  }
}

LazyDatabase _openConnection() {
  // the LazyDatabase util lets us find the right location for the file async.
  return LazyDatabase(() async {
    // put the database file, called db.sqlite here, into the documents folder
    // for your app.
    final dbFolder = await getApplicationDocumentsDirectory();
    final file = File(p.join(dbFolder.path, 'db.sqlite'));
    return NativeDatabase.createInBackground(file);
  });
}
