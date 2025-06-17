import 'package:dartz/dartz.dart';
import 'package:monday/datasource/local/database_impl.dart';
import 'package:monday/datasource/model/wallet_bank_model.dart';
import 'package:monday/utils/error/failure_response.dart';

abstract class WalletRepository {
  Future<Either<FailureResponse, int>>insertNewWallet(WalletCompanion userData);
  Future<Either<FailureResponse, int>>transferWallet(WalletData wallet);
  Future<Either<FailureResponse, List<WalletBankModel>>>getWallet();
  Future<Either<FailureResponse, List<WalletData>>>getWalletByMonth(int month);
}