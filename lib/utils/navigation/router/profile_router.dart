import 'package:monday/datasource/model/wallet_bank_model.dart';
import 'package:monday/domain/entities/user_entity.dart';
import 'package:monday/utils/navigation/navigation_helper.dart';
import 'package:monday/utils/navigation/router/app_router.dart';

abstract class ProfileRouter {
  void navigateToAccount();

  void navigateToDetailAccount(WalletBankModel walletBank);

  void navigateToSetting();

  void navigateToEditProfile(UserEntity userEntity);

  void navigateToAddNewAccount();

  void navigateToHome({int index});
}

class ProfileRouterImpl implements ProfileRouter {
  final NavigationHelper navigationHelper;

  ProfileRouterImpl({required this.navigationHelper});

  @override
  void navigateToAccount() {
    navigationHelper.pushReplacementNamed(AppRouter.account);
  }

  @override
  void navigateToSetting() {
    navigationHelper.pushReplacementNamed(AppRouter.setting);
  }

  @override
  void navigateToAddNewAccount() {
    navigationHelper.pushReplacementNamed(AppRouter.profileNewAccount);
  }

  @override
  void navigateToHome({int? index}) {
    navigationHelper.pushNamedAndRemoveUntil(AppRouter.home, arguments: index);
  }

  @override
  void navigateToDetailAccount(WalletBankModel walletBank) {
    navigationHelper.pushReplacementNamed(AppRouter.detailAccount, arguments: walletBank);
  }

  @override
  void navigateToEditProfile(UserEntity userEntity) {
    navigationHelper.pushReplacementNamed(AppRouter.editProfile, arguments: userEntity);
  }
}