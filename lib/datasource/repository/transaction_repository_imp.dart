import 'package:dartz/dartz.dart';
import 'package:drift/drift.dart';
import 'package:intl/intl.dart';
import 'package:monday/datasource/local/database_impl.dart';
import 'package:monday/datasource/mapper/transaction_mapper.dart';
import 'package:monday/domain/entities/transaction_entity.dart';
import 'package:monday/domain/repository/transaction_repository.dart';
import 'package:monday/utils/error/failure_response.dart';

class TransactionRepositoryImpl implements TransactionRepository {
  final DatabaseImpl databaseImpl;
  final TransactionMapper transactionMapper;

  TransactionRepositoryImpl(
      {required this.databaseImpl, required this.transactionMapper});

  @override
  Future<Either<FailureResponse, int>> insertTransaction(
      TransactionsCompanion transactionsCompanion) async {
    try {
      final result = await databaseImpl
          .into(databaseImpl.transactions)
          .insert(transactionsCompanion);
      return Right(result);
    } catch (e) {
      return Left(FailureResponse(
          errorMessage: 'There is an exception $e', statusCode: 0));
    }
  }

  @override
  Future<Either<FailureResponse, List<TransactionEntity>>> getAllTransaction(
      List<DateTime> date) async {
    try {
      DateFormat dateFormat = DateFormat("yyyy-MM-dd HH:mm");
      final query = databaseImpl.select(databaseImpl.transactions).join([
        leftOuterJoin(
            databaseImpl.categoryTransaction,
            databaseImpl.categoryTransaction.id
                .equalsExp(databaseImpl.transactions.idCategory),
            useColumns: true),
        leftOuterJoin(
            databaseImpl.transactionType,
            databaseImpl.transactionType.id
                .equalsExp(databaseImpl.transactions.idTransaction),
            useColumns: true),
        leftOuterJoin(
            databaseImpl.wallet,
            databaseImpl.wallet.id
                .equalsExp(databaseImpl.transactions.idWallet),
            useColumns: true),
        leftOuterJoin(databaseImpl.bank,
            databaseImpl.bank.id.equalsExp(databaseImpl.wallet.id),
            useColumns: true)
      ])
        ..where(databaseImpl.transactions.createDate
            .isBetweenValues(date[0], date[1]))
        ..orderBy([
          OrderingTerm(
              expression: databaseImpl.transactions.createDate,
              mode: OrderingMode.desc)
        ]);

      final data = await query.map((row) {
        final transaction = row.readTable(databaseImpl.transactions);
        final nameCategory = row.read(databaseImpl.categoryTransaction.name);
        final nameTypeTrans = row.read(databaseImpl.transactionType.name);
        final nameWallet = row.read(databaseImpl.bank.name);
        return TransactionEntity(
            id: transaction.id,
            idTransaction: transaction.idTransaction,
            idCategory: transaction.idCategory,
            idWallet: transaction.idWallet,
            categoryName: nameCategory,
            typeName: nameTypeTrans,
            walletName: nameWallet,
            price: transaction.price,
            description: transaction.description,
            idWalletFrom: transaction.idWalletFrom,
            idWalletTo: transaction.idWalletTo,
            pathImg: transaction.pathImg,
            date: dateFormat.parse(transaction.createDate.toString()));
      }).get();

      return Right(data);
    } catch (e) {
      return Left(FailureResponse(
          errorMessage: 'There is an exception $e', statusCode: 0));
    }
  }

  @override
  Future<Either<FailureResponse, List<TransactionEntity>>>
      getTransactionByIdWallet(int idWallet) async {
    // final data = await (databaseImpl.select(databaseImpl.transactions)
    //       ..where((tbl) => tbl.idWallet.equals(idWallet)))
    //     .get();
    DateFormat dateFormat = DateFormat("yyyy-MM-dd HH:mm");
    final query = databaseImpl.select(databaseImpl.transactions).join([
      leftOuterJoin(
          databaseImpl.categoryTransaction,
          databaseImpl.categoryTransaction.id
              .equalsExp(databaseImpl.transactions.idCategory),
          useColumns: true),
      leftOuterJoin(
          databaseImpl.transactionType,
          databaseImpl.transactionType.id
              .equalsExp(databaseImpl.transactions.idTransaction),
          useColumns: true),
      leftOuterJoin(databaseImpl.wallet,
          databaseImpl.wallet.id.equalsExp(databaseImpl.transactions.idWallet),
          useColumns: true),
      leftOuterJoin(databaseImpl.bank,
          databaseImpl.bank.id.equalsExp(databaseImpl.wallet.id),
          useColumns: true)
    ])
      ..where(databaseImpl.transactions.idWallet.equals(idWallet));

    final data = await query.map((row) {
      final transaction = row.readTable(databaseImpl.transactions);
      final nameCategory = row.read(databaseImpl.categoryTransaction.name);
      final nameTypeTrans = row.read(databaseImpl.transactionType.name);
      final nameWallet = row.read(databaseImpl.bank.name);
      return TransactionEntity(
          id: transaction.id,
          idTransaction: transaction.idTransaction,
          idCategory: transaction.idCategory,
          idWallet: transaction.idWallet,
          categoryName: nameCategory,
          typeName: nameTypeTrans,
          walletName: nameWallet,
          price: transaction.price,
          description: transaction.description,
          idWalletFrom: transaction.idWalletFrom,
          idWalletTo: transaction.idWalletTo,
          pathImg: transaction.pathImg,
          date: dateFormat.parse(transaction.createDate.toString()));
    }).get();

    return Right(data);
  }

  @override
  Future<Either<FailureResponse, List<TransactionEntity>>>
      getTransactionByIdCategoryAndMonth(int idCategory, int month) async {
    final data = await (databaseImpl.select(databaseImpl.transactions)
          ..where((tbl) => tbl.idCategory.equals(idCategory))
          ..where((tbl) => tbl.createDate.month.equals(month)))
        .get();

    return Right(transactionMapper.toModel(data));
  }

  @override
  Future<Either<FailureResponse, List<TransactionEntity>>>
      getTransactionByTransactionTypeAndMonth(int idTransaction, int month) async {
    final data = await (databaseImpl.select(databaseImpl.transactions)
          ..where((tbl) => tbl.idTransaction.equals(idTransaction))
          ..where((tbl) => tbl.createDate.month.equals(month)))
        .get();

    return Right(transactionMapper.toModel(data));
  }
}
