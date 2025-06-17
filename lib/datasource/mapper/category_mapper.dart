import 'package:monday/datasource/local/database_impl.dart';
import 'package:monday/domain/entities/category_transaction_entity.dart';
import 'package:monday/utils/base/mapper.dart';

class CategoryMapper
    implements
        Mapper<List<Category_transaction>, List<CategoryTransactionEntity>> {
  @override
  List<Category_transaction> toEntity(List<CategoryTransactionEntity> model) {
    final listCategory = <Category_transaction>[];
    for (var element in model) {
      listCategory.add(Category_transaction(
        id: element.id ?? 0,
        name: element.name
      ));
    }
    return listCategory;
  }

  @override
  List<CategoryTransactionEntity> toModel(List<Category_transaction> entity) {
    final listCategoryEntity = <CategoryTransactionEntity>[];
    for (var element in entity) {
      listCategoryEntity.add(CategoryTransactionEntity(
        id: element.id,
        name: element.name
      ));
    }
    return listCategoryEntity;
  }
}
