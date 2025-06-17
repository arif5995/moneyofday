import 'package:drift/drift.dart';

class Budget extends Table{
  IntColumn get id => integer().autoIncrement().nullable()();
  IntColumn get idCategory => integer().named("id_category")();
  TextColumn get categoryName => text().named("category_name")();
  IntColumn get price => integer()();
  BoolColumn get isNotice => boolean().named("is_notice").withDefault(const Constant(false))();
  DateTimeColumn get createDate => dateTime().named("create_date")();
}