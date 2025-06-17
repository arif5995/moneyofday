class AppConstants {
  static CachedKey cachedKey = const CachedKey();
  static AccountType accountType = const AccountType();
  static Category category = const Category();
  static Transaction transaction = const Transaction();
  static String newAccountKey = "formAccountKey";
}

class CachedKey {
  const CachedKey();

  String get onBoardingKey => 'onBoardingKey';

  String get tokenKey => 'tokenKey';

  String get fcmToken => 'fcmToken';
}

class AccountType {
  const AccountType();

  int get wallet => 1;

  int get bank => 2;
}

class Category {
  const Category();

  String get shopping => "Shopping";

  String get subscription => "Subscription";

  String get food => "Food";

  String get salary => "Salary";
  
  String get transferName => "Transfer";

  String get transportation => "Transportation";

  int get transferId => 6;

  int get salaryId => 4;

}

class Transaction {
  const Transaction();

  int get expanse => 1;

  int get income => 2;

  int get transfer => 3;
}
