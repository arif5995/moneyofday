import 'package:dartz/dartz.dart';
import 'package:monday/domain/entities/bank_entity.dart';
import 'package:monday/domain/repository/bank_repository.dart';
import 'package:monday/utils/error/failure_response.dart';
import 'package:monday/utils/usecase/use_case.dart';

class GetBankUseCase extends UseCase<List<BankEntity>, NoParams>{
  final BankRepository bankRepository;

  GetBankUseCase({required this.bankRepository});

  @override
  Future<Either<FailureResponse, List<BankEntity>>> call(params) async {
    return await bankRepository.getBank();
  }

}