import 'package:drift/drift.dart';

class Transaction extends Table{
  IntColumn get id => integer().autoIncrement()();
  IntColumn get idWallet => integer().named("id_wallet")();
  IntColumn get idTransactionType => integer().named("id_transaction_type")();
  IntColumn get idCategory => integer().named("id_category")();
  TextColumn get description => text()();
  TextColumn get path => text()();
  IntColumn get price => integer()();
  IntColumn get idWalletFrom => integer().named("id_wallet_form")();
  IntColumn get idWalletTo => integer().named("id_wallet_to")();
  TextColumn get date => text()();

}