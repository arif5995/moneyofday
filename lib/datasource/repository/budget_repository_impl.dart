import 'package:dartz/dartz.dart';
import 'package:drift/drift.dart';
import 'package:monday/datasource/local/database_impl.dart';
import 'package:monday/datasource/mapper/budget_mapper.dart';
import 'package:monday/domain/entities/budget_entity.dart';
import 'package:monday/domain/repository/budget_repository.dart';
import 'package:monday/utils/error/failure_response.dart';

class BudgetRepositoryImpl implements BudgetRepository {
  final DatabaseImpl databaseImpl;
  final BudgetMapper budgetMapper;

  BudgetRepositoryImpl(
      {required this.databaseImpl, required this.budgetMapper});

  @override
  Future<Either<FailureResponse, int>> insertBudget(
      BudgetEntity budgetEntity) async {
    try {
      final result = await databaseImpl.into(databaseImpl.budget).insert(
            BudgetCompanion.insert(
              idCategory: budgetEntity.idCategory,
              categoryName: budgetEntity.categoryName ?? "",
              price: int.parse(budgetEntity.price),
              isNotice: Value(
                budgetEntity.isNotice ?? false,
              ),
              createDate: budgetEntity.dateTime ?? DateTime.now(),
            ),
          );
      return Right(result);
    } catch (e) {
      return const Left(
        FailureResponse(errorMessage: "Failed insert budget"),
      );
    }
  }

  @override
  Future<Either<FailureResponse, List<BudgetEntity>>> getDataBudget(
      int month) async {
    try {
      final result = await (databaseImpl.select(databaseImpl.budget)
            ..where(
              (tbl) => tbl.createDate.month.equals(month),
            ))
          .get();
      // final query = databaseImpl.select(databaseImpl.budget).join([
      //   leftOuterJoin(
      //       databaseImpl.transactions,
      //       databaseImpl.transactions.idCategory
      //           .equalsExp(databaseImpl.budget.idCategory),
      //       useColumns: true)
      // ])
      //   ..where(databaseImpl.budget.createDate.month.equals(month))
      //   ..orderBy([
      //     OrderingTerm(
      //         expression: databaseImpl.budget.idCategory,
      //         mode: OrderingMode.asc)
      //   ]);
      //
      // final data = await query.map((row) {
      //   final tableBudget = row.readTable(databaseImpl.budget);
      //   final priceCategory = row.read(databaseImpl.transactions.price);
      //   return BudgetEntity(
      //       idCategory: tableBudget.idCategory,
      //       categoryName: tableBudget.categoryName,
      //       priceCategory: priceCategory,
      //       price: tableBudget.price.toString(),
      //       dateTime: tableBudget.createDate,
      //       isNotice: tableBudget.isNotice);
      // }).get();
      return Right(budgetMapper.toEntity(result));
    } catch (e) {
      return Left(
        FailureResponse(
          errorMessage: e.toString(),
        ),
      );
    }
  }

  @override
  Future<Either<FailureResponse, int>> updateBudget(
      BudgetEntity budgetEntity) async {
    try {
      final result = await (databaseImpl.update(databaseImpl.budget)
            ..where((tbl) => tbl.id.equals(budgetEntity.id ?? 0)))
          .write(
        BudgetCompanion(
          id: Value(budgetEntity.id ?? 0),
          idCategory: Value(budgetEntity.idCategory),
          categoryName: Value(budgetEntity.categoryName ?? ""),
          isNotice: Value(budgetEntity.isNotice ?? false),
          price: Value(int.parse(budgetEntity.price ?? "0")),
          createDate: Value(
            budgetEntity.dateTime ?? DateTime.now(),
          ),
        ),
      );

      return Right(result);
    } catch (e) {
      return Left(
        FailureResponse(
          errorMessage: e.toString(),
        ),
      );
    }
  }

  @override
  Future<Either<FailureResponse, int>> deleteBudget(int idBudget) async {
    try {
      final result = await(databaseImpl.delete(databaseImpl.budget)
            ..where((tbl) => tbl.id.equals(idBudget)))
          .go();
      return Right(result);
    } catch (e) {
      return Left(
        FailureResponse(
          errorMessage: e.toString(),
        ),
      );
    }
  }
}
