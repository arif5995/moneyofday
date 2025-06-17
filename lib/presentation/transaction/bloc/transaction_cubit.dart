import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:monday/domain/entities/transaction_entity.dart';
import 'package:monday/domain/usecase/get_transaction_usecase.dart';
import 'package:monday/utils/error/failure_response.dart';
import 'package:monday/utils/state/view_data_state.dart';
import 'package:monday/utils/usecase/use_case.dart';

part 'transaction_state.dart';

class TransactionCubit extends Cubit<TransactionState> {
  final GetTransactionUseCase getTransactionUseCase;

  TransactionCubit({required this.getTransactionUseCase})
      : super(
          TransactionState(
            listTransaction: ViewData.initial(),
          ),
        );

  void getListTransaction({int? month, int? day}) async {

    try {
      var listDate = <DateTime>[];
      DateTime dateTime = DateTime.now();
      var month1 = DateTime.utc(dateTime.year, month ?? dateTime.month, 1);
      var month2 = DateTime.utc(dateTime.year, month ?? dateTime.month, 30);
      listDate.add(month1);
      listDate.add(month2);

      final result = await getTransactionUseCase.call(listDate);

      result.fold((error) {
        emit(state.copyWith(
            listTransaction: ViewData.error(message: "", failure: error)));
      }, (data) {
        emit(
          state.copyWith(
            listTransaction: ViewData.loaded(data: data),
          ),
        );
      });
    } catch (e) {
      emit(
        state.copyWith(
          listTransaction: ViewData.error(
            message: "Error exception get picked",
            failure: FailureResponse(
              errorMessage: e.toString(),
            ),
          ),
        ),
      );
    }
  }
}
