import 'package:dartz/dartz.dart';
import 'package:drift/drift.dart';
import 'package:monday/datasource/local/database_impl.dart';
import 'package:monday/datasource/mapper/category_mapper.dart';
import 'package:monday/domain/entities/category_transaction_entity.dart';
import 'package:monday/domain/repository/category_transaction_repository.dart';
import 'package:monday/utils/error/failure_response.dart';

class CategoryTransactionRepositoryImp
    implements CategoryTransactionRepository {
  final DatabaseImpl databaseImpl;
  final CategoryMapper mapper;

  CategoryTransactionRepositoryImp(
      {required this.databaseImpl, required this.mapper});

  @override
  Future<Either<FailureResponse, List<CategoryTransactionEntity>>>
      getCategory() async {
    try {
      final data =
          await databaseImpl.select(databaseImpl.categoryTransaction).get();
      return Right(mapper.toModel(data));
    } catch (e) {
      return Left(FailureResponse(errorMessage: e.toString()));
    }
  }

  @override
  Future<Either<FailureResponse, int>> insertCategory(
      List<CategoryTransactionEntity> listCategory) async {
    try {
      await databaseImpl.batch((batch) {
        batch.insertAll(
            databaseImpl.categoryTransaction,
            listCategory
                .map((e) => CategoryTransactionCompanion.insert(name: e.name))
                .toList(),
            mode: InsertMode.insertOrReplace);
      });
      return const Right(1);
    } catch (e) {
      return Left(FailureResponse(errorMessage: e.toString()));
    }
  }
}
