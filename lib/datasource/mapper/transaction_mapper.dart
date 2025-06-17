import 'package:intl/intl.dart';
import 'package:monday/datasource/local/database_impl.dart';
import 'package:monday/domain/entities/transaction_entity.dart';
import 'package:monday/utils/base/mapper.dart';

class TransactionMapper
    implements Mapper<List<Transaction>, List<TransactionEntity>> {
  @override
  List<Transaction> toEntity(List<TransactionEntity> model) {
    final listTransaction = <Transaction>[];
    for (var element in model) {
      listTransaction.add(
        Transaction(
          id: element.id,
          idCategory: element.idCategory,
          idTransaction: element.idTransaction,
          idWallet: element.idWallet,
          idWalletFrom: element.idWalletFrom,
          idWalletTo: element.idWalletTo,
          price: element.price,
          description: element.description,
          pathImg: element.pathImg,
          createDate: element.date,
        ),
      );
    }
    return listTransaction;
  }

  @override
  List<TransactionEntity> toModel(List<Transaction> param){
    DateFormat dateFormat = DateFormat("yyyy-MM-dd HH:mm");
    final listTransactionEntity = <TransactionEntity>[];
    for (var element in param) {
      listTransactionEntity.add(
        TransactionEntity(
            id: element.id,
            idCategory: element.idCategory,
            idTransaction: element.idTransaction,
            idWallet: element.idWallet,
            idWalletFrom: element.idWalletFrom,
            idWalletTo: element.idWalletTo,
            price: element.price,
            description: element.description,
            pathImg: element.pathImg,
            date: dateFormat.parse(element.createDate.toString()),
        ),
      );
    }
    return listTransactionEntity;
  }
}
