import 'package:get_it/get_it.dart';
import 'package:image_picker/image_picker.dart';
import 'package:monday/datasource/local/database_impl.dart';
import 'package:monday/datasource/mapper/bank_mapper.dart';
import 'package:monday/datasource/mapper/budget_mapper.dart';
import 'package:monday/datasource/mapper/category_mapper.dart';
import 'package:monday/datasource/mapper/transaction_mapper.dart';
import 'package:monday/datasource/mapper/user_mapper.dart';
import 'package:monday/datasource/repository/bank_repository_impl.dart';
import 'package:monday/datasource/repository/budget_repository_impl.dart';
import 'package:monday/datasource/repository/category_transaction_repository_imp.dart';
import 'package:monday/datasource/repository/transaction_repository_imp.dart';
import 'package:monday/datasource/repository/user_repository_impl.dart';
import 'package:monday/datasource/repository/wallet_repository_impl.dart';
import 'package:monday/domain/repository/bank_repository.dart';
import 'package:monday/domain/repository/budget_repository.dart';
import 'package:monday/domain/repository/category_transaction_repository.dart';
import 'package:monday/domain/repository/transaction_repository.dart';
import 'package:monday/domain/repository/user_repository.dart';
import 'package:monday/domain/repository/wallet_repository.dart';
import 'package:monday/domain/usecase/delete_budget_usecase.dart';
import 'package:monday/domain/usecase/get_bank_usecase.dart';
import 'package:monday/domain/usecase/cache_onboarding_usecase.dart';
import 'package:monday/domain/usecase/get_budget_permonth_usecase.dart';
import 'package:monday/domain/usecase/get_cache_onboarding_usecase.dart';
import 'package:monday/domain/usecase/get_category_transaction_usecase.dart';
import 'package:monday/domain/usecase/get_transaction_by_idCategory_usecase.dart';
import 'package:monday/domain/usecase/get_transaction_by_id_transaction_usecase.dart';
import 'package:monday/domain/usecase/get_transaction_by_idwallet_usecase.dart';
import 'package:monday/domain/usecase/get_transaction_usecase.dart';
import 'package:monday/domain/usecase/get_wallet_by_month_usecase.dart';
import 'package:monday/domain/usecase/get_wallet_usecase.dart';
import 'package:monday/domain/usecase/insert_bank.dart';
import 'package:monday/domain/usecase/insert_budget_usecase.dart';
import 'package:monday/domain/usecase/insert_transaction_usecase.dart';
import 'package:monday/domain/usecase/insert_category_transaction_usecase.dart';
import 'package:monday/domain/usecase/insert_wallet_usecase.dart';
import 'package:monday/domain/usecase/update_budget_usecase.dart';
import 'package:monday/domain/usecase/update_wallet_usecase.dart';
import 'package:monday/utils/navigation/navigation_helper.dart';
import 'package:monday/utils/navigation/router/auth_router.dart';
import 'package:monday/utils/navigation/router/budget_router.dart';
import 'package:monday/utils/navigation/router/new_account_router.dart';
import 'package:monday/utils/navigation/router/onboarding_router.dart';
import 'package:monday/utils/navigation/router/profile_router.dart';
import 'package:monday/utils/navigation/router/transaction_router.dart';
import 'package:shared_preferences/shared_preferences.dart';

final sl = GetIt.instance;

class Injections {
  Future<void> initialize() async {
    final sharedPreferences = await SharedPreferences.getInstance();
    final ImagePicker imgpicker = ImagePicker();
    sl.registerLazySingleton(() => imgpicker);
    sl.registerLazySingleton(() => sharedPreferences);
    _registerMapper();
    _registrationDomain();
    _registrationDatasource();
    _registrationDatabase();
    _navigation();
    _router();
  }

  void _registerMapper() {
    sl.registerLazySingleton<BankMapper>(() => BankMapper());
    sl.registerLazySingleton<UserMapper>(() => UserMapper());
    sl.registerLazySingleton<TransactionMapper>(() => TransactionMapper());
    sl.registerLazySingleton<CategoryMapper>(() => CategoryMapper());
    sl.registerLazySingleton<BudgetMapper>(() => BudgetMapper());
  }

  void _registrationDomain() {
    sl.registerLazySingleton<CacheOnboardingUseCase>(
        () => CacheOnboardingUseCase(userRepository: sl()));
    sl.registerLazySingleton<GetOnboardingUseCase>(
            () => GetOnboardingUseCase(userRepository: sl()));
    sl.registerLazySingleton<InsertBankUseCase>(
        () => InsertBankUseCase(bankRepository: sl()));
    sl.registerLazySingleton<GetBankUseCase>(
        () => GetBankUseCase(bankRepository: sl()));
    sl.registerLazySingleton<InsertWalletUseCase>(
            () => InsertWalletUseCase(walletRepository: sl()));
    sl.registerLazySingleton<GetWalletUseCase>(
            () => GetWalletUseCase(walletRepository: sl()));
    sl.registerLazySingleton<InsertTransactionUseCase>(
            () => InsertTransactionUseCase(transactionRepository: sl()));
    sl.registerLazySingleton<GetTransactionUseCase>(
            () => GetTransactionUseCase(transactionRepository: sl()));
    sl.registerLazySingleton<GetCategoryTransactionUseCase>(
            () => GetCategoryTransactionUseCase(transactionRepository: sl()));
    sl.registerLazySingleton<InsertCategoryTransactionUseCase>(
            () => InsertCategoryTransactionUseCase(transactionRepository: sl()));
    sl.registerLazySingleton<UpdateWalletUseCase>(
            () => UpdateWalletUseCase(walletRepository: sl()));
    sl.registerLazySingleton<GetTransactionByIdWalletUseCase>(
            () => GetTransactionByIdWalletUseCase(transactionRepository: sl()));
    sl.registerLazySingleton<InsertBudgetUseCase>(
            () => InsertBudgetUseCase(budgetRepository: sl()));
    sl.registerLazySingleton<GetBudgetPerMonthUseCase>(
            () => GetBudgetPerMonthUseCase(budgetRepository: sl()));
    sl.registerLazySingleton<GetTransactionByIdCategoryUseCase>(
            () => GetTransactionByIdCategoryUseCase(transactionRepository: sl()));
    sl.registerLazySingleton<UpdateBudgetUseCase>(
            () => UpdateBudgetUseCase(budgetRepository: sl()));
    sl.registerLazySingleton<DeleteBudgetUseCase>(
            () => DeleteBudgetUseCase(budgetRepository: sl()));
    sl.registerLazySingleton<GetWalletByMonthUseCase>(
            () => GetWalletByMonthUseCase(walletRepository: sl()));
    sl.registerLazySingleton<GetTransactionByIdTransactionUseCase>(
            () => GetTransactionByIdTransactionUseCase(transactionRepository: sl()));
  }

  void _registrationDatasource() {
    sl.registerLazySingleton<UserRepository>(
        () => UserRepositoryImpl(databaseImpl: sl(), sharedPreferences: sl()));
    sl.registerLazySingleton<BankRepository>(
        () => BankRepositoryImpl(databaseImpl: sl(), bankMapper: sl()));
    sl.registerLazySingleton<WalletRepository>(
            () => WalletRepositoryImp(databaseImpl: sl()));
    sl.registerLazySingleton<TransactionRepository>(
            () => TransactionRepositoryImpl(databaseImpl: sl(), transactionMapper: sl()));
    sl.registerLazySingleton<CategoryTransactionRepository>(
            () => CategoryTransactionRepositoryImp(databaseImpl: sl(), mapper: sl()));
    sl.registerLazySingleton<BudgetRepository>(
            () => BudgetRepositoryImpl(databaseImpl: sl(), budgetMapper: sl()));
  }

  void _registrationDatabase() {
    sl.registerLazySingleton<DatabaseImpl>(() => DatabaseImpl());
  }

  void _navigation() => sl.registerLazySingleton<NavigationHelper>(
        () => NavigationHelperImpl(),
      );

  void _router() {
    sl.registerLazySingleton<OnboardingRouter>(
      () => OnboardingRouterImpl(
        navigationHelper: sl(),
      ),
    );
    sl.registerLazySingleton<AuthRouter>(
      () => AuthRouterImpl(
        navigationHelper: sl(),
      ),
    );
    sl.registerLazySingleton<NewAccountRouter>(
      () => NewAccountRouterImpl(
        navigationHelper: sl(),
      ),
    );
    sl.registerLazySingleton<TransactionRouter>(
          () => TransactionRouterImpl(
        navigationHelper: sl(),
      ),
    );
    sl.registerLazySingleton<ProfileRouter>(
          () => ProfileRouterImpl(
        navigationHelper: sl(),
      ),
    );
    sl.registerLazySingleton<BudgetRouter>(
          () => BudgetRouterImpl(
        navigationHelper: sl(),
      ),
    );
  }
}
