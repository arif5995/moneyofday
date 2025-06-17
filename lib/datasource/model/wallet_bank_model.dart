import 'package:monday/datasource/local/database_impl.dart';

class WalletBankModel{
  final WalletData walletData;
  final String nameBank;
  final String assetBank;

  WalletBankModel(this.walletData, this.nameBank, this.assetBank);
}