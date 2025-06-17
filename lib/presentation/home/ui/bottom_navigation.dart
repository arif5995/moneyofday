import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:monday/injections/injections.dart';
import 'package:monday/presentation/budget/ui/budget_screen.dart';
import 'package:monday/presentation/home/bloc/home_bloc/home_cubit.dart';
import 'package:monday/presentation/home/ui/home_screen.dart';
import 'package:monday/presentation/profile/ui/profile_screen.dart';
import 'package:monday/presentation/transaction/ui/transaction_screen.dart';
import 'package:monday/utils/gen/assets.gen.dart';
import 'package:monday/utils/gen/colors.gen.dart';
import 'package:monday/utils/navigation/router/transaction_router.dart';
import 'package:monday/utils/widget/bottom_app_bar_item.dart';

class BottomNavigation extends StatelessWidget {
  BottomNavigation({super.key});
  final TransactionRouter transactionRouter = sl();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeCubit, HomeState>(
      builder: (context, state) {
        return Scaffold(
          floatingActionButtonLocation:
              FloatingActionButtonLocation.miniCenterDocked,
          floatingActionButton: SizedBox(
            width: 55.w,
            height: 55.h,
            child: FabTransForm(
              ctx: context,
            ),
          ),
          floatingActionButtonAnimator: FloatingActionButtonAnimator.scaling,
          body: BlocBuilder<HomeCubit, HomeState>(
            builder: (context, state) {
              final isShowed = state.isShowFab.data;
              return Stack(
                children: [
                  SizedBox(
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height,
                    child: IndexedStack(
                      index: context.watch<HomeCubit>().state.homeState.data,
                      children: [
                        const HomeScreen(),
                        TransactionScreen(),
                        BudgetScreeen(),
                        ProfileScreen()
                      ],
                    ),
                  ),
                  Visibility(
                    visible: isShowed ?? false,
                    child: Positioned(
                      left: 120,
                      bottom: 40,
                      child: FloatingActionButton(
                        heroTag: "income",
                        backgroundColor: ColorName.green,
                        child: Assets.images.icons.income
                            .svg(width: 32.w, height: 32.w),
                        onPressed: () {
                          transactionRouter.navigateToIncome();
                        },
                      ),
                    ),
                  ),
                  Visibility(
                    visible: isShowed ?? false,
                    child: Positioned(
                      right: 120,
                      bottom: 40,
                      child: FloatingActionButton(
                        heroTag: "expense",
                        backgroundColor: ColorName.red,
                        child: Assets.images.icons.expense
                            .svg(width: 32.w, height: 32.w),
                        onPressed: () {
                          transactionRouter.navigateToExpanse();
                        },
                      ),
                    ),
                  ),
                  Visibility(
                    visible: isShowed ?? false,
                    child: Align(
                      alignment: Alignment.bottomCenter,
                      child: Padding(
                        padding: const EdgeInsets.only(bottom: 100),
                        child: FloatingActionButton(
                          heroTag: "currency",
                          backgroundColor: ColorName.blue,
                          child: Assets.images.icons.currency
                              .svg(width: 32.w, height: 32.w),
                          onPressed: () {
                            transactionRouter.navigateToTransfer();
                          },
                        ),
                      ),
                    ),
                  ),
                ],
              );
            },
          ),
          bottomNavigationBar: FABBottomAppBar(
            items: [
              BottomAppBarItem(
                  iconData: Assets.images.icons.home.path, textIcon: "Home"),
              BottomAppBarItem(
                  iconData: Assets.images.icons.transaction.path,
                  textIcon: "Transaction"),
              BottomAppBarItem(
                  iconData: Assets.images.icons.piechart.path,
                  textIcon: "Budget"),
              BottomAppBarItem(
                  iconData: Assets.images.icons.user.path, textIcon: "Account"),
            ],
            centerItemText: "",
            height: 50.h,
            iconSize: 24.sp,
            backgroundColor: ColorName.whiteBackground,
            color: ColorName.iconGrey,
            selectedColor: ColorName.purple,
            initiateIndex: context.watch<HomeCubit>().state.homeState.data,
            onTabSelected: (indx) {
              context.read<HomeCubit>().changeTab(tabIndex: indx);
            },
          ),
        );
      },
    );
  }
}

class FabTransForm extends StatefulWidget {
  final BuildContext ctx;

  const FabTransForm({super.key, required this.ctx});

  @override
  State<FabTransForm> createState() => _FabTransFormState();
}

class _FabTransFormState extends State<FabTransForm>
    with TickerProviderStateMixin {
  int _angle = 90;
  bool _isRotated = true;
  AnimationController? _controller;

  @override
  void initState() {
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 180),
    );



    _controller?.reverse();
    super.initState();
  }

  _rotate() {
    setState(() {
      if (_isRotated) {
        context.read<HomeCubit>().showMultipleFab(isShow: true);
        _angle = 45;
        _isRotated = false;
        _controller?.forward();
      } else {
        context.read<HomeCubit>().showMultipleFab(isShow: false);
        _angle = 90;
        _isRotated = true;
        _controller?.reverse();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      elevation: 2,
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(30.0))
      ),
      backgroundColor: ColorName.purple,
      onPressed: _rotate,
      child: RotationTransition(
        turns: AlwaysStoppedAnimation(_angle / 360),
        child: Icon(
          Icons.add,
          color: Colors.white,
          size: 25.sp,
        ),
      ),
    );
  }
}
