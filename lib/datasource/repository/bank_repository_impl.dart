import 'package:dartz/dartz.dart';
import 'package:drift/drift.dart';
import 'package:flutter/foundation.dart';
import 'package:monday/datasource/local/database_impl.dart';
import 'package:monday/datasource/mapper/bank_mapper.dart';
import 'package:monday/domain/entities/bank_entity.dart';
import 'package:monday/domain/repository/bank_repository.dart';
import 'package:monday/utils/error/failure_response.dart';

class BankRepositoryImpl implements BankRepository {
  final DatabaseImpl databaseImpl;
  final BankMapper bankMapper;

  BankRepositoryImpl({required this.databaseImpl, required this.bankMapper});

  @override
  Future<Either<FailureResponse, List<BankEntity>>> getBank()async{
    final listBank = <BankEntity>[];
    try{
      final result = await databaseImpl.select(databaseImpl.bank).get();
      for (var element in result) {
        final data = bankMapper.mapUserTableForUserEntity(element);
        listBank.add(data);
      }
      if (kDebugMode) {
        print("SELECT $listBank");
      }
      return Right(listBank);
    }catch(e){
      return Left(FailureResponse(errorMessage: e.toString()));
    }
  }

  @override
  Future<Either<FailureResponse, int>> insertBank(List<BankEntity> listBankEntity) async {
    try {
      await databaseImpl.delete(databaseImpl.bank).go();
      await databaseImpl.batch((batch){
        batch.insertAll(
            databaseImpl.bank,
            listBankEntity.map((e) => BankCompanion.insert(name: e.name, pathImage: e.image)).toList(),
            mode: InsertMode.insertOrReplace);
      });
      return const Right(1);
    } catch (e) {
      return Left(FailureResponse(errorMessage: e.toString()));
    }
  }
}
