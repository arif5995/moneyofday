import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:monday/domain/entities/category_transaction_entity.dart';
import 'package:monday/domain/usecase/get_cache_onboarding_usecase.dart';
import 'package:monday/domain/usecase/get_category_transaction_usecase.dart';
import 'package:monday/domain/usecase/insert_category_transaction_usecase.dart';
import 'package:monday/utils/error/failure_response.dart';
import 'package:monday/utils/state/view_data_state.dart';
import 'package:monday/utils/usecase/use_case.dart';

part 'splash_state.dart';

class SplashCubit extends Cubit<SplashState> {
  final GetOnboardingUseCase getOnboardingUseCase;
  final InsertCategoryTransactionUseCase insertCategoryTransactionUseCase;
  final GetCategoryTransactionUseCase getCategoryTransactionUseCase;

  SplashCubit(
      {required this.getOnboardingUseCase,
      required this.insertCategoryTransactionUseCase,
      required this.getCategoryTransactionUseCase})
      : super(
          SplashState(
            splashState: ViewData.initial(),
            category: ViewData.initial(),
          ),
        );

  void initSplash() async {
    final onBoardingStatus = await getOnboardingUseCase.call(const NoParams());
    onBoardingStatus.fold(
        (failure) => emit(state.copyWith(
              splashState: ViewData.error(
                  message: failure.errorMessage, failure: failure),
            )), (data) async {
      if (data) {
        emit(
          state.copyWith(
            splashState: ViewData.loaded(data: data),
          ),
        );
      } else {
        final data = await getCategoryTransactionUseCase.call(const NoParams());
        data.fold((l) => null, (listCategory) async {
          if(listCategory.isEmpty){
            final categoryTransaction = <CategoryTransactionEntity>[];

            categoryTransaction
                .add(const CategoryTransactionEntity(name: "Shopping"));
            categoryTransaction
                .add(const CategoryTransactionEntity(name: "Subscription"));
            categoryTransaction
                .add(const CategoryTransactionEntity(name: "Transportation"));
            categoryTransaction.add(const CategoryTransactionEntity(name: "Salary"));
            categoryTransaction.add(const CategoryTransactionEntity(name: "Food"));
            categoryTransaction
                .add(const CategoryTransactionEntity(name: "Transfer"));

            final result =
            await insertCategoryTransactionUseCase.call(categoryTransaction);

            result.fold((error) {
              emit(
                state.copyWith(
                  category:
                  ViewData.error(message: "Category is null", failure: error),
                ),
              );
            }, (data) {
              emit(state.copyWith(category: ViewData.loaded(data: data)));
            });
          }
        });
        emit(
          state.copyWith(
            splashState: ViewData.noData(message: "Data Kosong"),
          ),
        );
      }
    });
  }

  void insertCategoryTransaction() async {
    emit(
      state.copyWith(
        splashState: ViewData.initial(),
      ),
    );
    final data = await getCategoryTransactionUseCase.call(const NoParams());
    data.fold((l) => null, (listCategory) async {
      if(listCategory.isEmpty){
        final categoryTransaction = <CategoryTransactionEntity>[];

        categoryTransaction
            .add(const CategoryTransactionEntity(name: "Shopping"));
        categoryTransaction
            .add(const CategoryTransactionEntity(name: "Subscription"));
        categoryTransaction
            .add(const CategoryTransactionEntity(name: "Transportation"));
        categoryTransaction.add(const CategoryTransactionEntity(name: "Salary"));
        categoryTransaction.add(const CategoryTransactionEntity(name: "Food"));
        categoryTransaction
            .add(const CategoryTransactionEntity(name: "Transfer"));

        final result =
        await insertCategoryTransactionUseCase.call(categoryTransaction);

        result.fold((error) {
          emit(
            state.copyWith(
              category:
              ViewData.error(message: "Category is null", failure: error),
            ),
          );
        }, (data) {
          emit(state.copyWith(category: ViewData.loaded(data: data)));
        });
      }
    });
  }
}
