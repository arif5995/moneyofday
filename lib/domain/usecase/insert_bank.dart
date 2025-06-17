import 'package:dartz/dartz.dart';
import 'package:monday/domain/entities/bank_entity.dart';
import 'package:monday/domain/repository/bank_repository.dart';
import 'package:monday/utils/error/failure_response.dart';
import 'package:monday/utils/usecase/use_case.dart';

class InsertBankUseCase extends UseCase<int, List<BankEntity>>{
  final BankRepository bankRepository;

  InsertBankUseCase({required this.bankRepository});

  @override
  Future<Either<FailureResponse, int>> call(List<BankEntity> params) async {
    return await bankRepository.insertBank(params);
  }

}