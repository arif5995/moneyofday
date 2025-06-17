import 'package:dartz/dartz.dart';
import 'package:monday/domain/entities/bank_entity.dart';
import 'package:monday/utils/error/failure_response.dart';

abstract class BankRepository{
  Future<Either<FailureResponse, int>>insertBank(List<BankEntity> listBankEntity);
  Future<Either<FailureResponse, List<BankEntity>>>getBank();
}