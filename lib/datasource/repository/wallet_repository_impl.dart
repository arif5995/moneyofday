import 'package:dartz/dartz.dart';
import 'package:drift/drift.dart';
import 'package:monday/datasource/local/database_impl.dart';
import 'package:monday/datasource/model/wallet_bank_model.dart';
import 'package:monday/domain/repository/wallet_repository.dart';
import 'package:monday/utils/error/failure_response.dart';

class WalletRepositoryImp implements WalletRepository {
  final DatabaseImpl databaseImpl;

  WalletRepositoryImp({required this.databaseImpl});

  @override
  Future<Either<FailureResponse, int>> insertNewWallet(
      WalletCompanion walletData) async {
    try {
      final data =
          await databaseImpl.into(databaseImpl.wallet).insert(walletData);
      if (data != 0) {
        return Right(data);
      } else {
        return const Left(
            FailureResponse(errorMessage: "Gagal Insert", statusCode: 0));
      }
    } catch (e) {
      return const Left(FailureResponse(
          errorMessage: 'There is an exception.', statusCode: 0));
    }
  }

  @override
  Future<Either<FailureResponse, List<WalletBankModel>>> getWallet() async {
    try {
      final query = databaseImpl.select(databaseImpl.wallet).join([
        leftOuterJoin(databaseImpl.bank,
            databaseImpl.bank.id.equalsExp(databaseImpl.wallet.idBank),
            useColumns: true)
      ]);

      final data = await query.map((row) {
        final wallet = row.readTable(databaseImpl.wallet);
        final nameBank = row.read(databaseImpl.bank.name);
        final assetImg = row.read(databaseImpl.bank.pathImage);
        return WalletBankModel(wallet, nameBank ?? "Cash", assetImg ?? "");
      }).get();

      return Right(data);
    } catch (e) {
      return const Left(FailureResponse(
          errorMessage: 'There is an exception.', statusCode: 0));
    }
  }

  @override
  Future<Either<FailureResponse, int>> transferWallet(WalletData wallet) async {
    try {
      (databaseImpl.update(databaseImpl.wallet)
            ..where((tbl) => tbl.id.equals(wallet.id ?? 0)))
          .write(WalletCompanion(
              idBank: Value(wallet.idBank),
              price: Value(wallet.price),
              accountType: Value(wallet.accountType),
              name: Value(wallet.name)));
      return const Right(1);
    } catch (e) {
      return const Left(FailureResponse(
          errorMessage: 'There is an exception.', statusCode: 0));
    }
  }

  @override
  Future<Either<FailureResponse, List<WalletData>>> getWalletByMonth(int month) async{
    try {
      final data = await (databaseImpl.select(databaseImpl.wallet)..where((tbl) => tbl.createDate.month.equals(month))).get();
      return Right(data);
    } catch (e) {
      return const Left(FailureResponse(
          errorMessage: 'There is an exception.', statusCode: 0));
    }
  }
}
