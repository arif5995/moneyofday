import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:monday/datasource/model/wallet_bank_model.dart';
import 'package:monday/domain/entities/budget_entity.dart';
import 'package:monday/domain/entities/transaction_entity.dart';
import 'package:monday/injections/injections.dart';
import 'package:monday/presentation/budget/bloc/budget_cubit.dart';
import 'package:monday/presentation/budget/ui/create_budget_screen.dart';
import 'package:monday/presentation/budget/ui/detail_budget_screen.dart';
import 'package:monday/presentation/budget/ui/edit_budget_screen.dart';
import 'package:monday/presentation/expanse/bloc/expanse_cubit.dart';
import 'package:monday/presentation/expanse/ui/expanse_screen.dart';
import 'package:monday/presentation/home/bloc/home_bloc/home_cubit.dart';
import 'package:monday/presentation/home/ui/bottom_navigation.dart';
import 'package:monday/presentation/income/bloc/income_cubit.dart';
import 'package:monday/presentation/income/ui/income_screen.dart';
import 'package:monday/presentation/newAccount/bloc/account/account_cubit.dart';
import 'package:monday/presentation/newAccount/ui/add_new_account_screen.dart';
import 'package:monday/presentation/newAccount/ui/success_screen.dart';
import 'package:monday/presentation/onboarding/bloc/splash_bloc/splash_cubit.dart';
import 'package:monday/presentation/onboarding/ui/intro_screen.dart';
import 'package:monday/presentation/onboarding/ui/onboarding_screen.dart';
import 'package:monday/presentation/onboarding/ui/splash_screen.dart';
import 'package:monday/presentation/profile/bloc/profile_cubit.dart';
import 'package:monday/presentation/profile/ui/account_profile.dart';
import 'package:monday/presentation/profile/ui/detail_account.dart';
import 'package:monday/presentation/profile/ui/profile_add_new_account.dart';
import 'package:monday/presentation/profile/ui/profile_edit_screen.dart';
import 'package:monday/presentation/transaction/bloc/transaction_cubit.dart';
import 'package:monday/presentation/transfer/bloc/transfer_cubit.dart';
import 'package:monday/presentation/transfer/ui/transfer_screen.dart';
import 'package:monday/utils/gen/colors.gen.dart';
import 'package:monday/utils/navigation/navigation_helper.dart';
import 'package:monday/utils/navigation/router/app_router.dart';
import 'package:monday/utils/widget/detail_item_transaction.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // FlipperClient flipperClient = FlipperClient.getDefault();
  // flipperClient.addPlugin(FlipperReduxInspectorPlugin());
  // flipperClient.addPlugin(FlipperSharedPreferencesPlugin());
  // flipperClient.start();
  await Injections().initialize();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return ScreenUtilInit(
        designSize: const Size(375, 855),
        builder: (_, __) => MaterialApp(
              title: "Flutter Mondays",
              debugShowCheckedModeBanner: false,
              theme: ThemeData(
                  useMaterial3: true,
                  primaryColor: ColorName.whiteBackground,
                  textTheme: GoogleFonts.aBeeZeeTextTheme(textTheme).copyWith(
                    bodyMedium:
                        GoogleFonts.aBeeZee(textStyle: textTheme.bodyMedium),
                  ),
                  canvasColor: Colors.transparent,
                  bottomSheetTheme: const BottomSheetThemeData(
                      backgroundColor: ColorName.whiteBackground)),
              home: MultiBlocProvider(
                providers: [
                  BlocProvider(
                    create: (context) => SplashCubit(
                        getOnboardingUseCase: sl(),
                        insertCategoryTransactionUseCase: sl(),
                        getCategoryTransactionUseCase: sl())
                      ..initSplash(),
                  ),
                ],
                child: SplashScreen(),
              ),
              navigatorKey: NavigationHelperImpl.navigationKey,
              onGenerateRoute: (RouteSettings settings) {
                final argument = settings.arguments;
                switch (settings.name) {
                  case AppRouter.onboarding:
                    return MaterialPageRoute(
                        builder: (_) => OnboardingScreen());
                  case AppRouter.intro:
                    return MaterialPageRoute(
                      builder: (_) => BlocProvider(
                        create: (context) => AccountCubit(
                            insertBankUseCase: sl(),
                            getBankUseCase: sl(),
                            insertWalletUseCase: sl(),
                            cacheOnboardingUseCase: sl()),
                        child: IntroScreen(),
                      ),
                    );
                  case AppRouter.newAddAccount:
                    return MaterialPageRoute(
                      builder: (_) => BlocProvider(
                        create: (context) => AccountCubit(
                            insertBankUseCase: sl(),
                            getBankUseCase: sl(),
                            insertWalletUseCase: sl(),
                            cacheOnboardingUseCase: sl())
                          ..initiateAccountType(accType: "Account Type"),
                        child: const AddNewAccountScreen(),
                      ),
                    );
                  case AppRouter.newAddSucces:
                    return MaterialPageRoute(
                      builder: (_) => BlocProvider(
                        create: (context) => AccountCubit(
                            insertBankUseCase: sl(),
                            getBankUseCase: sl(),
                            insertWalletUseCase: sl(),
                            cacheOnboardingUseCase: sl()),
                        child: SuccessScreen(),
                      ),
                    );
                  case AppRouter.home:
                    return MaterialPageRoute(
                      builder: (_) => MultiBlocProvider(
                        providers: [
                          BlocProvider(
                            create: (context) => HomeCubit(
                                getTransactionUseCase: sl(),
                                getWalletUsecase: sl(),
                                getWalletByMonthUseCase: sl(),
                                getTransactionByIdTransactionUseCase: sl())
                              ..changeTab(tabIndex: argument as int)
                              ..showMultipleFab(isShow: false)
                              ..tabPeriod(id: 1)
                              ..currentMonth(),
                          ),
                          BlocProvider(
                            create: (context) =>
                                TransactionCubit(getTransactionUseCase: sl())
                                  ..getListTransaction(),
                          ),
                          BlocProvider(
                            create: (context) => ProfileCubit(
                              insertWalletUseCase: sl(),
                              getBankUseCase: sl(),
                              insertBankUseCase: sl(),
                              getWalletUsecase: sl(),
                              getTransactionByIdWalletUseCase: sl(),
                            )..getBank(),
                          ),
                          BlocProvider(
                            create: (context) => BudgetCubit(
                              getCategoryTransactionUseCase: sl(),
                              insertBudgetUseCase: sl(),
                              getBudgetPerMonthUseCase: sl(),
                              getTransactionByIdCategoryUseCase: sl(),
                              updateBudgetUseCase: sl(),
                              deleteBudgetUseCase: sl(),
                            )..initiateMonth(),
                          )
                        ],
                        child: BottomNavigation(),
                      ),
                    );
                  case AppRouter.expanse:
                    return MaterialPageRoute(
                        builder: (_) => BlocProvider(
                              create: (context) => ExpanseCubit(
                                  getWalletUsecase: sl(),
                                  insertTransactionUseCase: sl(),
                                  imagePicker: sl(),
                                  getCategoryTransactionUseCase: sl(),
                                  updateWalletUseCase: sl())
                                ..getWalletData()
                                ..getCategoryTransaction(),
                              child: const ExpanseScreen(),
                            ));
                  case AppRouter.income:
                    return MaterialPageRoute(
                        builder: (_) => BlocProvider(
                              create: (context) => IncomeCubit(
                                  getWalletUsecase: sl(),
                                  imagePicker: sl(),
                                  insertTransactionUseCase: sl(),
                                  updateWalletUseCase: sl())
                                ..getWalletData(),
                              child: const IncomeScreen(),
                            ));
                  case AppRouter.transfer:
                    return MaterialPageRoute(
                      builder: (_) => BlocProvider(
                        create: (context) => TransferCubit(
                            getWalletUsecase: sl(),
                            imagePicker: sl(),
                            insertTransactionUseCase: sl(),
                            updateWalletUseCase: sl())
                          ..getWalletFrom(),
                        child: const TransferScreen(),
                      ),
                    );
                  case AppRouter.account:
                    return MaterialPageRoute(
                      builder: (_) => BlocProvider(
                        create: (context) => ProfileCubit(
                          insertWalletUseCase: sl(),
                          getBankUseCase: sl(),
                          insertBankUseCase: sl(),
                          getWalletUsecase: sl(),
                          getTransactionByIdWalletUseCase: sl(),
                        )..getBank(),
                        child: AccountScreen(),
                      ),
                    );
                  case AppRouter.detailAccount:
                    final walletBank = argument as WalletBankModel;
                    return MaterialPageRoute(
                      builder: (_) => BlocProvider(
                        create: (context) => ProfileCubit(
                          insertWalletUseCase: sl(),
                          getBankUseCase: sl(),
                          insertBankUseCase: sl(),
                          getWalletUsecase: sl(),
                          getTransactionByIdWalletUseCase: sl(),
                        )..detailTransaction(
                            idWallet: walletBank.walletData.idBank),
                        child: DetailAccount(
                          walletBankModel: walletBank,
                        ),
                      ),
                    );
                  case AppRouter.profileNewAccount:
                    return MaterialPageRoute(
                      builder: (_) => BlocProvider(
                        create: (context) => ProfileCubit(
                            insertWalletUseCase: sl(),
                            getBankUseCase: sl(),
                            insertBankUseCase: sl(),
                            getWalletUsecase: sl(),
                            getTransactionByIdWalletUseCase: sl())
                          ..getBank(),
                        child: const ProfileAddNewAccountScreen(),
                      ),
                    );
                  case AppRouter.editProfile:
                    return MaterialPageRoute(
                        builder: (_) => ProfileEditScreen());
                  case AppRouter.detailTransaction:
                    return MaterialPageRoute(
                      builder: (_) => MultiBlocProvider(
                        providers: [
                          BlocProvider(
                            create: (context) => HomeCubit(
                              getTransactionUseCase: sl(),
                              getWalletUsecase: sl(),
                              getWalletByMonthUseCase: sl(),
                              getTransactionByIdTransactionUseCase: sl(),
                            ),
                          ),
                          BlocProvider(
                            create: (context) =>
                                TransactionCubit(getTransactionUseCase: sl()),
                          ),
                        ],
                        child: DetailItemTransaction(
                          argument: argument as TransactionEntity,
                        ),
                      ),
                    );
                  case AppRouter.createBudget:
                    return MaterialPageRoute(
                      builder: (_) => BlocProvider(
                        create: (context) => BudgetCubit(
                          getCategoryTransactionUseCase: sl(),
                          insertBudgetUseCase: sl(),
                          getBudgetPerMonthUseCase: sl(),
                          getTransactionByIdCategoryUseCase: sl(),
                          updateBudgetUseCase: sl(),
                          deleteBudgetUseCase: sl(),
                        )..getCategory(),
                        child: CreateBudgetScreen(),
                      ),
                    );
                  case AppRouter.detailBudget:
                    return MaterialPageRoute(
                        builder: (_) => BlocProvider(
                              create: (context) => BudgetCubit(
                                getCategoryTransactionUseCase: sl(),
                                insertBudgetUseCase: sl(),
                                getBudgetPerMonthUseCase: sl(),
                                getTransactionByIdCategoryUseCase: sl(),
                                updateBudgetUseCase: sl(),
                                deleteBudgetUseCase: sl(),
                              ),
                              child: DetailBudgetScreen(
                                budgetEntity: argument as BudgetEntity,
                              ),
                            ));
                  case AppRouter.editBudget:
                    return MaterialPageRoute(
                      builder: (_) => BlocProvider(
                        create: (context) => BudgetCubit(
                          getCategoryTransactionUseCase: sl(),
                          insertBudgetUseCase: sl(),
                          getBudgetPerMonthUseCase: sl(),
                          getTransactionByIdCategoryUseCase: sl(),
                          updateBudgetUseCase: sl(),
                          deleteBudgetUseCase: sl(),
                        )
                          ..getCategory()
                          ..changeNotice(
                            isNotice: argument.isNotice ?? false,
                          ),
                        child: EditBudgetScreen(
                          budgetEntity: argument as BudgetEntity,
                        ),
                      ),
                    );
                  default:
                    return MaterialPageRoute(builder: (_) => SplashScreen());
                }
              },
            ));
  }
}
