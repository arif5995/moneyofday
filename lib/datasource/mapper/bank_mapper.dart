import 'package:monday/datasource/local/database_impl.dart';
import 'package:monday/domain/entities/bank_entity.dart';

class BankMapper {
  BankData mapBankEntityForBankTable(BankEntity bankEntity) => BankData(
      name: bankEntity.name, pathImage: bankEntity.image, id: int.parse(bankEntity.idBank ?? "0"));

  BankEntity mapUserTableForUserEntity(BankData bankData) => BankEntity(
      idBank: bankData.id.toString(), name: bankData.name, image: bankData.pathImage);

}