import 'package:monday/datasource/local/database_impl.dart';
import 'package:monday/domain/entities/budget_entity.dart';
import 'package:monday/utils/base/mapper.dart';

class BudgetMapper implements Mapper<List<BudgetEntity>, List<BudgetData>> {
  @override
  List<BudgetEntity> toEntity(List<BudgetData> model) {
    final listEntity = <BudgetEntity>[];
    for (var element in model) {
      listEntity.add(BudgetEntity(
          id: element.id,
          idCategory: element.idCategory,
          categoryName: element.categoryName,
          isNotice: element.isNotice,
          price: element.price.toString(),
          dateTime: element.createDate));
    }
    return listEntity;
  }

  @override
  List<BudgetData> toModel(List<BudgetEntity> entity) {
    final listBudget = <BudgetData>[];
    for (var element in entity) {
      listBudget.add(
        BudgetData(
            idCategory: element.idCategory,
            categoryName: element.categoryName.toString(),
            price: int.parse(element.price),
            isNotice: element.isNotice ?? false,
            createDate: element.dateTime ?? DateTime.now()),
      );
    }
    return listBudget;
  }
}
