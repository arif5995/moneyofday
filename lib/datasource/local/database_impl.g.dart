// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'database_impl.dart';

// ignore_for_file: type=lint
class $UserTable extends User with TableInfo<$UserTable, UserData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $UserTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, true,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
      'name', aliasedName, false,
      additionalChecks:
          GeneratedColumn.checkTextLength(minTextLength: 6, maxTextLength: 32),
      type: DriftSqlType.string,
      requiredDuringInsert: true);
  static const VerificationMeta _photoMeta = const VerificationMeta('photo');
  @override
  late final GeneratedColumn<String> photo = GeneratedColumn<String>(
      'photo', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns => [id, name, photo];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'user';
  @override
  VerificationContext validateIntegrity(Insertable<UserData> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('name')) {
      context.handle(
          _nameMeta, name.isAcceptableOrUnknown(data['name']!, _nameMeta));
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('photo')) {
      context.handle(
          _photoMeta, photo.isAcceptableOrUnknown(data['photo']!, _photoMeta));
    } else if (isInserting) {
      context.missing(_photoMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  UserData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return UserData(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id']),
      name: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}name'])!,
      photo: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}photo'])!,
    );
  }

  @override
  $UserTable createAlias(String alias) {
    return $UserTable(attachedDatabase, alias);
  }
}

class UserData extends DataClass implements Insertable<UserData> {
  final int? id;
  final String name;
  final String photo;
  const UserData({this.id, required this.name, required this.photo});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (!nullToAbsent || id != null) {
      map['id'] = Variable<int>(id);
    }
    map['name'] = Variable<String>(name);
    map['photo'] = Variable<String>(photo);
    return map;
  }

  UserCompanion toCompanion(bool nullToAbsent) {
    return UserCompanion(
      id: id == null && nullToAbsent ? const Value.absent() : Value(id),
      name: Value(name),
      photo: Value(photo),
    );
  }

  factory UserData.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return UserData(
      id: serializer.fromJson<int?>(json['id']),
      name: serializer.fromJson<String>(json['name']),
      photo: serializer.fromJson<String>(json['photo']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int?>(id),
      'name': serializer.toJson<String>(name),
      'photo': serializer.toJson<String>(photo),
    };
  }

  UserData copyWith(
          {Value<int?> id = const Value.absent(),
          String? name,
          String? photo}) =>
      UserData(
        id: id.present ? id.value : this.id,
        name: name ?? this.name,
        photo: photo ?? this.photo,
      );
  @override
  String toString() {
    return (StringBuffer('UserData(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('photo: $photo')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, name, photo);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is UserData &&
          other.id == this.id &&
          other.name == this.name &&
          other.photo == this.photo);
}

class UserCompanion extends UpdateCompanion<UserData> {
  final Value<int?> id;
  final Value<String> name;
  final Value<String> photo;
  const UserCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    this.photo = const Value.absent(),
  });
  UserCompanion.insert({
    this.id = const Value.absent(),
    required String name,
    required String photo,
  })  : name = Value(name),
        photo = Value(photo);
  static Insertable<UserData> custom({
    Expression<int>? id,
    Expression<String>? name,
    Expression<String>? photo,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (name != null) 'name': name,
      if (photo != null) 'photo': photo,
    });
  }

  UserCompanion copyWith(
      {Value<int?>? id, Value<String>? name, Value<String>? photo}) {
    return UserCompanion(
      id: id ?? this.id,
      name: name ?? this.name,
      photo: photo ?? this.photo,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (photo.present) {
      map['photo'] = Variable<String>(photo.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('UserCompanion(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('photo: $photo')
          ..write(')'))
        .toString();
  }
}

class $BankTable extends Bank with TableInfo<$BankTable, BankData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $BankTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
      'name', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _pathImageMeta =
      const VerificationMeta('pathImage');
  @override
  late final GeneratedColumn<String> pathImage = GeneratedColumn<String>(
      'path_image', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns => [id, name, pathImage];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'bank';
  @override
  VerificationContext validateIntegrity(Insertable<BankData> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('name')) {
      context.handle(
          _nameMeta, name.isAcceptableOrUnknown(data['name']!, _nameMeta));
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('path_image')) {
      context.handle(_pathImageMeta,
          pathImage.isAcceptableOrUnknown(data['path_image']!, _pathImageMeta));
    } else if (isInserting) {
      context.missing(_pathImageMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  BankData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return BankData(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      name: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}name'])!,
      pathImage: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}path_image'])!,
    );
  }

  @override
  $BankTable createAlias(String alias) {
    return $BankTable(attachedDatabase, alias);
  }
}

class BankData extends DataClass implements Insertable<BankData> {
  final int id;
  final String name;
  final String pathImage;
  const BankData(
      {required this.id, required this.name, required this.pathImage});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['name'] = Variable<String>(name);
    map['path_image'] = Variable<String>(pathImage);
    return map;
  }

  BankCompanion toCompanion(bool nullToAbsent) {
    return BankCompanion(
      id: Value(id),
      name: Value(name),
      pathImage: Value(pathImage),
    );
  }

  factory BankData.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return BankData(
      id: serializer.fromJson<int>(json['id']),
      name: serializer.fromJson<String>(json['name']),
      pathImage: serializer.fromJson<String>(json['pathImage']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'name': serializer.toJson<String>(name),
      'pathImage': serializer.toJson<String>(pathImage),
    };
  }

  BankData copyWith({int? id, String? name, String? pathImage}) => BankData(
        id: id ?? this.id,
        name: name ?? this.name,
        pathImage: pathImage ?? this.pathImage,
      );
  @override
  String toString() {
    return (StringBuffer('BankData(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('pathImage: $pathImage')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, name, pathImage);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is BankData &&
          other.id == this.id &&
          other.name == this.name &&
          other.pathImage == this.pathImage);
}

class BankCompanion extends UpdateCompanion<BankData> {
  final Value<int> id;
  final Value<String> name;
  final Value<String> pathImage;
  const BankCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    this.pathImage = const Value.absent(),
  });
  BankCompanion.insert({
    this.id = const Value.absent(),
    required String name,
    required String pathImage,
  })  : name = Value(name),
        pathImage = Value(pathImage);
  static Insertable<BankData> custom({
    Expression<int>? id,
    Expression<String>? name,
    Expression<String>? pathImage,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (name != null) 'name': name,
      if (pathImage != null) 'path_image': pathImage,
    });
  }

  BankCompanion copyWith(
      {Value<int>? id, Value<String>? name, Value<String>? pathImage}) {
    return BankCompanion(
      id: id ?? this.id,
      name: name ?? this.name,
      pathImage: pathImage ?? this.pathImage,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (pathImage.present) {
      map['path_image'] = Variable<String>(pathImage.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('BankCompanion(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('pathImage: $pathImage')
          ..write(')'))
        .toString();
  }
}

class $WalletTable extends Wallet with TableInfo<$WalletTable, WalletData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $WalletTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, true,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
      'name', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _idBankMeta = const VerificationMeta('idBank');
  @override
  late final GeneratedColumn<int> idBank = GeneratedColumn<int>(
      'id_bank', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  static const VerificationMeta _priceMeta = const VerificationMeta('price');
  @override
  late final GeneratedColumn<int> price = GeneratedColumn<int>(
      'price', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  static const VerificationMeta _accountTypeMeta =
      const VerificationMeta('accountType');
  @override
  late final GeneratedColumn<String> accountType = GeneratedColumn<String>(
      'account_type', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _createDateMeta =
      const VerificationMeta('createDate');
  @override
  late final GeneratedColumn<DateTime> createDate = GeneratedColumn<DateTime>(
      'create_date', aliasedName, false,
      type: DriftSqlType.dateTime, requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns =>
      [id, name, idBank, price, accountType, createDate];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'wallet';
  @override
  VerificationContext validateIntegrity(Insertable<WalletData> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('name')) {
      context.handle(
          _nameMeta, name.isAcceptableOrUnknown(data['name']!, _nameMeta));
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('id_bank')) {
      context.handle(_idBankMeta,
          idBank.isAcceptableOrUnknown(data['id_bank']!, _idBankMeta));
    } else if (isInserting) {
      context.missing(_idBankMeta);
    }
    if (data.containsKey('price')) {
      context.handle(
          _priceMeta, price.isAcceptableOrUnknown(data['price']!, _priceMeta));
    } else if (isInserting) {
      context.missing(_priceMeta);
    }
    if (data.containsKey('account_type')) {
      context.handle(
          _accountTypeMeta,
          accountType.isAcceptableOrUnknown(
              data['account_type']!, _accountTypeMeta));
    } else if (isInserting) {
      context.missing(_accountTypeMeta);
    }
    if (data.containsKey('create_date')) {
      context.handle(
          _createDateMeta,
          createDate.isAcceptableOrUnknown(
              data['create_date']!, _createDateMeta));
    } else if (isInserting) {
      context.missing(_createDateMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  WalletData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return WalletData(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id']),
      name: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}name'])!,
      idBank: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id_bank'])!,
      price: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}price'])!,
      accountType: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}account_type'])!,
      createDate: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}create_date'])!,
    );
  }

  @override
  $WalletTable createAlias(String alias) {
    return $WalletTable(attachedDatabase, alias);
  }
}

class WalletData extends DataClass implements Insertable<WalletData> {
  final int? id;
  final String name;
  final int idBank;
  final int price;
  final String accountType;
  final DateTime createDate;
  const WalletData(
      {this.id,
      required this.name,
      required this.idBank,
      required this.price,
      required this.accountType,
      required this.createDate});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (!nullToAbsent || id != null) {
      map['id'] = Variable<int>(id);
    }
    map['name'] = Variable<String>(name);
    map['id_bank'] = Variable<int>(idBank);
    map['price'] = Variable<int>(price);
    map['account_type'] = Variable<String>(accountType);
    map['create_date'] = Variable<DateTime>(createDate);
    return map;
  }

  WalletCompanion toCompanion(bool nullToAbsent) {
    return WalletCompanion(
      id: id == null && nullToAbsent ? const Value.absent() : Value(id),
      name: Value(name),
      idBank: Value(idBank),
      price: Value(price),
      accountType: Value(accountType),
      createDate: Value(createDate),
    );
  }

  factory WalletData.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return WalletData(
      id: serializer.fromJson<int?>(json['id']),
      name: serializer.fromJson<String>(json['name']),
      idBank: serializer.fromJson<int>(json['idBank']),
      price: serializer.fromJson<int>(json['price']),
      accountType: serializer.fromJson<String>(json['accountType']),
      createDate: serializer.fromJson<DateTime>(json['createDate']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int?>(id),
      'name': serializer.toJson<String>(name),
      'idBank': serializer.toJson<int>(idBank),
      'price': serializer.toJson<int>(price),
      'accountType': serializer.toJson<String>(accountType),
      'createDate': serializer.toJson<DateTime>(createDate),
    };
  }

  WalletData copyWith(
          {Value<int?> id = const Value.absent(),
          String? name,
          int? idBank,
          int? price,
          String? accountType,
          DateTime? createDate}) =>
      WalletData(
        id: id.present ? id.value : this.id,
        name: name ?? this.name,
        idBank: idBank ?? this.idBank,
        price: price ?? this.price,
        accountType: accountType ?? this.accountType,
        createDate: createDate ?? this.createDate,
      );
  @override
  String toString() {
    return (StringBuffer('WalletData(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('idBank: $idBank, ')
          ..write('price: $price, ')
          ..write('accountType: $accountType, ')
          ..write('createDate: $createDate')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(id, name, idBank, price, accountType, createDate);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is WalletData &&
          other.id == this.id &&
          other.name == this.name &&
          other.idBank == this.idBank &&
          other.price == this.price &&
          other.accountType == this.accountType &&
          other.createDate == this.createDate);
}

class WalletCompanion extends UpdateCompanion<WalletData> {
  final Value<int?> id;
  final Value<String> name;
  final Value<int> idBank;
  final Value<int> price;
  final Value<String> accountType;
  final Value<DateTime> createDate;
  const WalletCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    this.idBank = const Value.absent(),
    this.price = const Value.absent(),
    this.accountType = const Value.absent(),
    this.createDate = const Value.absent(),
  });
  WalletCompanion.insert({
    this.id = const Value.absent(),
    required String name,
    required int idBank,
    required int price,
    required String accountType,
    required DateTime createDate,
  })  : name = Value(name),
        idBank = Value(idBank),
        price = Value(price),
        accountType = Value(accountType),
        createDate = Value(createDate);
  static Insertable<WalletData> custom({
    Expression<int>? id,
    Expression<String>? name,
    Expression<int>? idBank,
    Expression<int>? price,
    Expression<String>? accountType,
    Expression<DateTime>? createDate,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (name != null) 'name': name,
      if (idBank != null) 'id_bank': idBank,
      if (price != null) 'price': price,
      if (accountType != null) 'account_type': accountType,
      if (createDate != null) 'create_date': createDate,
    });
  }

  WalletCompanion copyWith(
      {Value<int?>? id,
      Value<String>? name,
      Value<int>? idBank,
      Value<int>? price,
      Value<String>? accountType,
      Value<DateTime>? createDate}) {
    return WalletCompanion(
      id: id ?? this.id,
      name: name ?? this.name,
      idBank: idBank ?? this.idBank,
      price: price ?? this.price,
      accountType: accountType ?? this.accountType,
      createDate: createDate ?? this.createDate,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (idBank.present) {
      map['id_bank'] = Variable<int>(idBank.value);
    }
    if (price.present) {
      map['price'] = Variable<int>(price.value);
    }
    if (accountType.present) {
      map['account_type'] = Variable<String>(accountType.value);
    }
    if (createDate.present) {
      map['create_date'] = Variable<DateTime>(createDate.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('WalletCompanion(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('idBank: $idBank, ')
          ..write('price: $price, ')
          ..write('accountType: $accountType, ')
          ..write('createDate: $createDate')
          ..write(')'))
        .toString();
  }
}

class $TransactionsTable extends Transactions
    with TableInfo<$TransactionsTable, Transaction> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $TransactionsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _idTransactionMeta =
      const VerificationMeta('idTransaction');
  @override
  late final GeneratedColumn<int> idTransaction = GeneratedColumn<int>(
      'id_transaction', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  static const VerificationMeta _idCategoryMeta =
      const VerificationMeta('idCategory');
  @override
  late final GeneratedColumn<int> idCategory = GeneratedColumn<int>(
      'id_category', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  static const VerificationMeta _idWalletMeta =
      const VerificationMeta('idWallet');
  @override
  late final GeneratedColumn<int> idWallet = GeneratedColumn<int>(
      'id_wallet', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  static const VerificationMeta _descriptionMeta =
      const VerificationMeta('description');
  @override
  late final GeneratedColumn<String> description = GeneratedColumn<String>(
      'description', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _pathImgMeta =
      const VerificationMeta('pathImg');
  @override
  late final GeneratedColumn<String> pathImg = GeneratedColumn<String>(
      'path_img', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _idWalletFromMeta =
      const VerificationMeta('idWalletFrom');
  @override
  late final GeneratedColumn<int> idWalletFrom = GeneratedColumn<int>(
      'id_wallet_from', aliasedName, true,
      type: DriftSqlType.int, requiredDuringInsert: false);
  static const VerificationMeta _idWalletToMeta =
      const VerificationMeta('idWalletTo');
  @override
  late final GeneratedColumn<int> idWalletTo = GeneratedColumn<int>(
      'id_wallet_to', aliasedName, true,
      type: DriftSqlType.int, requiredDuringInsert: false);
  static const VerificationMeta _priceMeta = const VerificationMeta('price');
  @override
  late final GeneratedColumn<String> price = GeneratedColumn<String>(
      'price', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _createDateMeta =
      const VerificationMeta('createDate');
  @override
  late final GeneratedColumn<DateTime> createDate = GeneratedColumn<DateTime>(
      'create_date', aliasedName, false,
      type: DriftSqlType.dateTime, requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns => [
        id,
        idTransaction,
        idCategory,
        idWallet,
        description,
        pathImg,
        idWalletFrom,
        idWalletTo,
        price,
        createDate
      ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'transactions';
  @override
  VerificationContext validateIntegrity(Insertable<Transaction> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('id_transaction')) {
      context.handle(
          _idTransactionMeta,
          idTransaction.isAcceptableOrUnknown(
              data['id_transaction']!, _idTransactionMeta));
    } else if (isInserting) {
      context.missing(_idTransactionMeta);
    }
    if (data.containsKey('id_category')) {
      context.handle(
          _idCategoryMeta,
          idCategory.isAcceptableOrUnknown(
              data['id_category']!, _idCategoryMeta));
    } else if (isInserting) {
      context.missing(_idCategoryMeta);
    }
    if (data.containsKey('id_wallet')) {
      context.handle(_idWalletMeta,
          idWallet.isAcceptableOrUnknown(data['id_wallet']!, _idWalletMeta));
    } else if (isInserting) {
      context.missing(_idWalletMeta);
    }
    if (data.containsKey('description')) {
      context.handle(
          _descriptionMeta,
          description.isAcceptableOrUnknown(
              data['description']!, _descriptionMeta));
    }
    if (data.containsKey('path_img')) {
      context.handle(_pathImgMeta,
          pathImg.isAcceptableOrUnknown(data['path_img']!, _pathImgMeta));
    }
    if (data.containsKey('id_wallet_from')) {
      context.handle(
          _idWalletFromMeta,
          idWalletFrom.isAcceptableOrUnknown(
              data['id_wallet_from']!, _idWalletFromMeta));
    }
    if (data.containsKey('id_wallet_to')) {
      context.handle(
          _idWalletToMeta,
          idWalletTo.isAcceptableOrUnknown(
              data['id_wallet_to']!, _idWalletToMeta));
    }
    if (data.containsKey('price')) {
      context.handle(
          _priceMeta, price.isAcceptableOrUnknown(data['price']!, _priceMeta));
    } else if (isInserting) {
      context.missing(_priceMeta);
    }
    if (data.containsKey('create_date')) {
      context.handle(
          _createDateMeta,
          createDate.isAcceptableOrUnknown(
              data['create_date']!, _createDateMeta));
    } else if (isInserting) {
      context.missing(_createDateMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Transaction map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Transaction(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      idTransaction: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id_transaction'])!,
      idCategory: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id_category'])!,
      idWallet: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id_wallet'])!,
      description: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}description']),
      pathImg: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}path_img']),
      idWalletFrom: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id_wallet_from']),
      idWalletTo: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id_wallet_to']),
      price: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}price'])!,
      createDate: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}create_date'])!,
    );
  }

  @override
  $TransactionsTable createAlias(String alias) {
    return $TransactionsTable(attachedDatabase, alias);
  }
}

class Transaction extends DataClass implements Insertable<Transaction> {
  final int id;
  final int idTransaction;
  final int idCategory;
  final int idWallet;
  final String? description;
  final String? pathImg;
  final int? idWalletFrom;
  final int? idWalletTo;
  final String price;
  final DateTime createDate;
  const Transaction(
      {required this.id,
      required this.idTransaction,
      required this.idCategory,
      required this.idWallet,
      this.description,
      this.pathImg,
      this.idWalletFrom,
      this.idWalletTo,
      required this.price,
      required this.createDate});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['id_transaction'] = Variable<int>(idTransaction);
    map['id_category'] = Variable<int>(idCategory);
    map['id_wallet'] = Variable<int>(idWallet);
    if (!nullToAbsent || description != null) {
      map['description'] = Variable<String>(description);
    }
    if (!nullToAbsent || pathImg != null) {
      map['path_img'] = Variable<String>(pathImg);
    }
    if (!nullToAbsent || idWalletFrom != null) {
      map['id_wallet_from'] = Variable<int>(idWalletFrom);
    }
    if (!nullToAbsent || idWalletTo != null) {
      map['id_wallet_to'] = Variable<int>(idWalletTo);
    }
    map['price'] = Variable<String>(price);
    map['create_date'] = Variable<DateTime>(createDate);
    return map;
  }

  TransactionsCompanion toCompanion(bool nullToAbsent) {
    return TransactionsCompanion(
      id: Value(id),
      idTransaction: Value(idTransaction),
      idCategory: Value(idCategory),
      idWallet: Value(idWallet),
      description: description == null && nullToAbsent
          ? const Value.absent()
          : Value(description),
      pathImg: pathImg == null && nullToAbsent
          ? const Value.absent()
          : Value(pathImg),
      idWalletFrom: idWalletFrom == null && nullToAbsent
          ? const Value.absent()
          : Value(idWalletFrom),
      idWalletTo: idWalletTo == null && nullToAbsent
          ? const Value.absent()
          : Value(idWalletTo),
      price: Value(price),
      createDate: Value(createDate),
    );
  }

  factory Transaction.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Transaction(
      id: serializer.fromJson<int>(json['id']),
      idTransaction: serializer.fromJson<int>(json['idTransaction']),
      idCategory: serializer.fromJson<int>(json['idCategory']),
      idWallet: serializer.fromJson<int>(json['idWallet']),
      description: serializer.fromJson<String?>(json['description']),
      pathImg: serializer.fromJson<String?>(json['pathImg']),
      idWalletFrom: serializer.fromJson<int?>(json['idWalletFrom']),
      idWalletTo: serializer.fromJson<int?>(json['idWalletTo']),
      price: serializer.fromJson<String>(json['price']),
      createDate: serializer.fromJson<DateTime>(json['createDate']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'idTransaction': serializer.toJson<int>(idTransaction),
      'idCategory': serializer.toJson<int>(idCategory),
      'idWallet': serializer.toJson<int>(idWallet),
      'description': serializer.toJson<String?>(description),
      'pathImg': serializer.toJson<String?>(pathImg),
      'idWalletFrom': serializer.toJson<int?>(idWalletFrom),
      'idWalletTo': serializer.toJson<int?>(idWalletTo),
      'price': serializer.toJson<String>(price),
      'createDate': serializer.toJson<DateTime>(createDate),
    };
  }

  Transaction copyWith(
          {int? id,
          int? idTransaction,
          int? idCategory,
          int? idWallet,
          Value<String?> description = const Value.absent(),
          Value<String?> pathImg = const Value.absent(),
          Value<int?> idWalletFrom = const Value.absent(),
          Value<int?> idWalletTo = const Value.absent(),
          String? price,
          DateTime? createDate}) =>
      Transaction(
        id: id ?? this.id,
        idTransaction: idTransaction ?? this.idTransaction,
        idCategory: idCategory ?? this.idCategory,
        idWallet: idWallet ?? this.idWallet,
        description: description.present ? description.value : this.description,
        pathImg: pathImg.present ? pathImg.value : this.pathImg,
        idWalletFrom:
            idWalletFrom.present ? idWalletFrom.value : this.idWalletFrom,
        idWalletTo: idWalletTo.present ? idWalletTo.value : this.idWalletTo,
        price: price ?? this.price,
        createDate: createDate ?? this.createDate,
      );
  @override
  String toString() {
    return (StringBuffer('Transaction(')
          ..write('id: $id, ')
          ..write('idTransaction: $idTransaction, ')
          ..write('idCategory: $idCategory, ')
          ..write('idWallet: $idWallet, ')
          ..write('description: $description, ')
          ..write('pathImg: $pathImg, ')
          ..write('idWalletFrom: $idWalletFrom, ')
          ..write('idWalletTo: $idWalletTo, ')
          ..write('price: $price, ')
          ..write('createDate: $createDate')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, idTransaction, idCategory, idWallet,
      description, pathImg, idWalletFrom, idWalletTo, price, createDate);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Transaction &&
          other.id == this.id &&
          other.idTransaction == this.idTransaction &&
          other.idCategory == this.idCategory &&
          other.idWallet == this.idWallet &&
          other.description == this.description &&
          other.pathImg == this.pathImg &&
          other.idWalletFrom == this.idWalletFrom &&
          other.idWalletTo == this.idWalletTo &&
          other.price == this.price &&
          other.createDate == this.createDate);
}

class TransactionsCompanion extends UpdateCompanion<Transaction> {
  final Value<int> id;
  final Value<int> idTransaction;
  final Value<int> idCategory;
  final Value<int> idWallet;
  final Value<String?> description;
  final Value<String?> pathImg;
  final Value<int?> idWalletFrom;
  final Value<int?> idWalletTo;
  final Value<String> price;
  final Value<DateTime> createDate;
  const TransactionsCompanion({
    this.id = const Value.absent(),
    this.idTransaction = const Value.absent(),
    this.idCategory = const Value.absent(),
    this.idWallet = const Value.absent(),
    this.description = const Value.absent(),
    this.pathImg = const Value.absent(),
    this.idWalletFrom = const Value.absent(),
    this.idWalletTo = const Value.absent(),
    this.price = const Value.absent(),
    this.createDate = const Value.absent(),
  });
  TransactionsCompanion.insert({
    this.id = const Value.absent(),
    required int idTransaction,
    required int idCategory,
    required int idWallet,
    this.description = const Value.absent(),
    this.pathImg = const Value.absent(),
    this.idWalletFrom = const Value.absent(),
    this.idWalletTo = const Value.absent(),
    required String price,
    required DateTime createDate,
  })  : idTransaction = Value(idTransaction),
        idCategory = Value(idCategory),
        idWallet = Value(idWallet),
        price = Value(price),
        createDate = Value(createDate);
  static Insertable<Transaction> custom({
    Expression<int>? id,
    Expression<int>? idTransaction,
    Expression<int>? idCategory,
    Expression<int>? idWallet,
    Expression<String>? description,
    Expression<String>? pathImg,
    Expression<int>? idWalletFrom,
    Expression<int>? idWalletTo,
    Expression<String>? price,
    Expression<DateTime>? createDate,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (idTransaction != null) 'id_transaction': idTransaction,
      if (idCategory != null) 'id_category': idCategory,
      if (idWallet != null) 'id_wallet': idWallet,
      if (description != null) 'description': description,
      if (pathImg != null) 'path_img': pathImg,
      if (idWalletFrom != null) 'id_wallet_from': idWalletFrom,
      if (idWalletTo != null) 'id_wallet_to': idWalletTo,
      if (price != null) 'price': price,
      if (createDate != null) 'create_date': createDate,
    });
  }

  TransactionsCompanion copyWith(
      {Value<int>? id,
      Value<int>? idTransaction,
      Value<int>? idCategory,
      Value<int>? idWallet,
      Value<String?>? description,
      Value<String?>? pathImg,
      Value<int?>? idWalletFrom,
      Value<int?>? idWalletTo,
      Value<String>? price,
      Value<DateTime>? createDate}) {
    return TransactionsCompanion(
      id: id ?? this.id,
      idTransaction: idTransaction ?? this.idTransaction,
      idCategory: idCategory ?? this.idCategory,
      idWallet: idWallet ?? this.idWallet,
      description: description ?? this.description,
      pathImg: pathImg ?? this.pathImg,
      idWalletFrom: idWalletFrom ?? this.idWalletFrom,
      idWalletTo: idWalletTo ?? this.idWalletTo,
      price: price ?? this.price,
      createDate: createDate ?? this.createDate,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (idTransaction.present) {
      map['id_transaction'] = Variable<int>(idTransaction.value);
    }
    if (idCategory.present) {
      map['id_category'] = Variable<int>(idCategory.value);
    }
    if (idWallet.present) {
      map['id_wallet'] = Variable<int>(idWallet.value);
    }
    if (description.present) {
      map['description'] = Variable<String>(description.value);
    }
    if (pathImg.present) {
      map['path_img'] = Variable<String>(pathImg.value);
    }
    if (idWalletFrom.present) {
      map['id_wallet_from'] = Variable<int>(idWalletFrom.value);
    }
    if (idWalletTo.present) {
      map['id_wallet_to'] = Variable<int>(idWalletTo.value);
    }
    if (price.present) {
      map['price'] = Variable<String>(price.value);
    }
    if (createDate.present) {
      map['create_date'] = Variable<DateTime>(createDate.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('TransactionsCompanion(')
          ..write('id: $id, ')
          ..write('idTransaction: $idTransaction, ')
          ..write('idCategory: $idCategory, ')
          ..write('idWallet: $idWallet, ')
          ..write('description: $description, ')
          ..write('pathImg: $pathImg, ')
          ..write('idWalletFrom: $idWalletFrom, ')
          ..write('idWalletTo: $idWalletTo, ')
          ..write('price: $price, ')
          ..write('createDate: $createDate')
          ..write(')'))
        .toString();
  }
}

class $CategoryTransactionTable extends CategoryTransaction
    with TableInfo<$CategoryTransactionTable, Category_transaction> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $CategoryTransactionTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
      'name', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns => [id, name];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'category_transaction';
  @override
  VerificationContext validateIntegrity(
      Insertable<Category_transaction> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('name')) {
      context.handle(
          _nameMeta, name.isAcceptableOrUnknown(data['name']!, _nameMeta));
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Category_transaction map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Category_transaction(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      name: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}name'])!,
    );
  }

  @override
  $CategoryTransactionTable createAlias(String alias) {
    return $CategoryTransactionTable(attachedDatabase, alias);
  }
}

class Category_transaction extends DataClass
    implements Insertable<Category_transaction> {
  final int id;
  final String name;
  const Category_transaction({required this.id, required this.name});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['name'] = Variable<String>(name);
    return map;
  }

  CategoryTransactionCompanion toCompanion(bool nullToAbsent) {
    return CategoryTransactionCompanion(
      id: Value(id),
      name: Value(name),
    );
  }

  factory Category_transaction.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Category_transaction(
      id: serializer.fromJson<int>(json['id']),
      name: serializer.fromJson<String>(json['name']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'name': serializer.toJson<String>(name),
    };
  }

  Category_transaction copyWith({int? id, String? name}) =>
      Category_transaction(
        id: id ?? this.id,
        name: name ?? this.name,
      );
  @override
  String toString() {
    return (StringBuffer('Category_transaction(')
          ..write('id: $id, ')
          ..write('name: $name')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, name);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Category_transaction &&
          other.id == this.id &&
          other.name == this.name);
}

class CategoryTransactionCompanion
    extends UpdateCompanion<Category_transaction> {
  final Value<int> id;
  final Value<String> name;
  const CategoryTransactionCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
  });
  CategoryTransactionCompanion.insert({
    this.id = const Value.absent(),
    required String name,
  }) : name = Value(name);
  static Insertable<Category_transaction> custom({
    Expression<int>? id,
    Expression<String>? name,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (name != null) 'name': name,
    });
  }

  CategoryTransactionCompanion copyWith({Value<int>? id, Value<String>? name}) {
    return CategoryTransactionCompanion(
      id: id ?? this.id,
      name: name ?? this.name,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('CategoryTransactionCompanion(')
          ..write('id: $id, ')
          ..write('name: $name')
          ..write(')'))
        .toString();
  }
}

class $TransactionTypeTable extends TransactionType
    with TableInfo<$TransactionTypeTable, Transaction_type> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $TransactionTypeTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
      'name', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns => [id, name];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'transaction_type';
  @override
  VerificationContext validateIntegrity(Insertable<Transaction_type> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('name')) {
      context.handle(
          _nameMeta, name.isAcceptableOrUnknown(data['name']!, _nameMeta));
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Transaction_type map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Transaction_type(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      name: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}name'])!,
    );
  }

  @override
  $TransactionTypeTable createAlias(String alias) {
    return $TransactionTypeTable(attachedDatabase, alias);
  }
}

class Transaction_type extends DataClass
    implements Insertable<Transaction_type> {
  final int id;
  final String name;
  const Transaction_type({required this.id, required this.name});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['name'] = Variable<String>(name);
    return map;
  }

  TransactionTypeCompanion toCompanion(bool nullToAbsent) {
    return TransactionTypeCompanion(
      id: Value(id),
      name: Value(name),
    );
  }

  factory Transaction_type.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Transaction_type(
      id: serializer.fromJson<int>(json['id']),
      name: serializer.fromJson<String>(json['name']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'name': serializer.toJson<String>(name),
    };
  }

  Transaction_type copyWith({int? id, String? name}) => Transaction_type(
        id: id ?? this.id,
        name: name ?? this.name,
      );
  @override
  String toString() {
    return (StringBuffer('Transaction_type(')
          ..write('id: $id, ')
          ..write('name: $name')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, name);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Transaction_type &&
          other.id == this.id &&
          other.name == this.name);
}

class TransactionTypeCompanion extends UpdateCompanion<Transaction_type> {
  final Value<int> id;
  final Value<String> name;
  const TransactionTypeCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
  });
  TransactionTypeCompanion.insert({
    this.id = const Value.absent(),
    required String name,
  }) : name = Value(name);
  static Insertable<Transaction_type> custom({
    Expression<int>? id,
    Expression<String>? name,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (name != null) 'name': name,
    });
  }

  TransactionTypeCompanion copyWith({Value<int>? id, Value<String>? name}) {
    return TransactionTypeCompanion(
      id: id ?? this.id,
      name: name ?? this.name,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('TransactionTypeCompanion(')
          ..write('id: $id, ')
          ..write('name: $name')
          ..write(')'))
        .toString();
  }
}

class $BudgetTable extends Budget with TableInfo<$BudgetTable, BudgetData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $BudgetTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, true,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _idCategoryMeta =
      const VerificationMeta('idCategory');
  @override
  late final GeneratedColumn<int> idCategory = GeneratedColumn<int>(
      'id_category', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  static const VerificationMeta _categoryNameMeta =
      const VerificationMeta('categoryName');
  @override
  late final GeneratedColumn<String> categoryName = GeneratedColumn<String>(
      'category_name', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _priceMeta = const VerificationMeta('price');
  @override
  late final GeneratedColumn<int> price = GeneratedColumn<int>(
      'price', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  static const VerificationMeta _isNoticeMeta =
      const VerificationMeta('isNotice');
  @override
  late final GeneratedColumn<bool> isNotice = GeneratedColumn<bool>(
      'is_notice', aliasedName, false,
      type: DriftSqlType.bool,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('CHECK ("is_notice" IN (0, 1))'),
      defaultValue: const Constant(false));
  static const VerificationMeta _createDateMeta =
      const VerificationMeta('createDate');
  @override
  late final GeneratedColumn<DateTime> createDate = GeneratedColumn<DateTime>(
      'create_date', aliasedName, false,
      type: DriftSqlType.dateTime, requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns =>
      [id, idCategory, categoryName, price, isNotice, createDate];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'budget';
  @override
  VerificationContext validateIntegrity(Insertable<BudgetData> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('id_category')) {
      context.handle(
          _idCategoryMeta,
          idCategory.isAcceptableOrUnknown(
              data['id_category']!, _idCategoryMeta));
    } else if (isInserting) {
      context.missing(_idCategoryMeta);
    }
    if (data.containsKey('category_name')) {
      context.handle(
          _categoryNameMeta,
          categoryName.isAcceptableOrUnknown(
              data['category_name']!, _categoryNameMeta));
    } else if (isInserting) {
      context.missing(_categoryNameMeta);
    }
    if (data.containsKey('price')) {
      context.handle(
          _priceMeta, price.isAcceptableOrUnknown(data['price']!, _priceMeta));
    } else if (isInserting) {
      context.missing(_priceMeta);
    }
    if (data.containsKey('is_notice')) {
      context.handle(_isNoticeMeta,
          isNotice.isAcceptableOrUnknown(data['is_notice']!, _isNoticeMeta));
    }
    if (data.containsKey('create_date')) {
      context.handle(
          _createDateMeta,
          createDate.isAcceptableOrUnknown(
              data['create_date']!, _createDateMeta));
    } else if (isInserting) {
      context.missing(_createDateMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  BudgetData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return BudgetData(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id']),
      idCategory: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id_category'])!,
      categoryName: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}category_name'])!,
      price: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}price'])!,
      isNotice: attachedDatabase.typeMapping
          .read(DriftSqlType.bool, data['${effectivePrefix}is_notice'])!,
      createDate: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}create_date'])!,
    );
  }

  @override
  $BudgetTable createAlias(String alias) {
    return $BudgetTable(attachedDatabase, alias);
  }
}

class BudgetData extends DataClass implements Insertable<BudgetData> {
  final int? id;
  final int idCategory;
  final String categoryName;
  final int price;
  final bool isNotice;
  final DateTime createDate;
  const BudgetData(
      {this.id,
      required this.idCategory,
      required this.categoryName,
      required this.price,
      required this.isNotice,
      required this.createDate});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (!nullToAbsent || id != null) {
      map['id'] = Variable<int>(id);
    }
    map['id_category'] = Variable<int>(idCategory);
    map['category_name'] = Variable<String>(categoryName);
    map['price'] = Variable<int>(price);
    map['is_notice'] = Variable<bool>(isNotice);
    map['create_date'] = Variable<DateTime>(createDate);
    return map;
  }

  BudgetCompanion toCompanion(bool nullToAbsent) {
    return BudgetCompanion(
      id: id == null && nullToAbsent ? const Value.absent() : Value(id),
      idCategory: Value(idCategory),
      categoryName: Value(categoryName),
      price: Value(price),
      isNotice: Value(isNotice),
      createDate: Value(createDate),
    );
  }

  factory BudgetData.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return BudgetData(
      id: serializer.fromJson<int?>(json['id']),
      idCategory: serializer.fromJson<int>(json['idCategory']),
      categoryName: serializer.fromJson<String>(json['categoryName']),
      price: serializer.fromJson<int>(json['price']),
      isNotice: serializer.fromJson<bool>(json['isNotice']),
      createDate: serializer.fromJson<DateTime>(json['createDate']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int?>(id),
      'idCategory': serializer.toJson<int>(idCategory),
      'categoryName': serializer.toJson<String>(categoryName),
      'price': serializer.toJson<int>(price),
      'isNotice': serializer.toJson<bool>(isNotice),
      'createDate': serializer.toJson<DateTime>(createDate),
    };
  }

  BudgetData copyWith(
          {Value<int?> id = const Value.absent(),
          int? idCategory,
          String? categoryName,
          int? price,
          bool? isNotice,
          DateTime? createDate}) =>
      BudgetData(
        id: id.present ? id.value : this.id,
        idCategory: idCategory ?? this.idCategory,
        categoryName: categoryName ?? this.categoryName,
        price: price ?? this.price,
        isNotice: isNotice ?? this.isNotice,
        createDate: createDate ?? this.createDate,
      );
  @override
  String toString() {
    return (StringBuffer('BudgetData(')
          ..write('id: $id, ')
          ..write('idCategory: $idCategory, ')
          ..write('categoryName: $categoryName, ')
          ..write('price: $price, ')
          ..write('isNotice: $isNotice, ')
          ..write('createDate: $createDate')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(id, idCategory, categoryName, price, isNotice, createDate);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is BudgetData &&
          other.id == this.id &&
          other.idCategory == this.idCategory &&
          other.categoryName == this.categoryName &&
          other.price == this.price &&
          other.isNotice == this.isNotice &&
          other.createDate == this.createDate);
}

class BudgetCompanion extends UpdateCompanion<BudgetData> {
  final Value<int?> id;
  final Value<int> idCategory;
  final Value<String> categoryName;
  final Value<int> price;
  final Value<bool> isNotice;
  final Value<DateTime> createDate;
  const BudgetCompanion({
    this.id = const Value.absent(),
    this.idCategory = const Value.absent(),
    this.categoryName = const Value.absent(),
    this.price = const Value.absent(),
    this.isNotice = const Value.absent(),
    this.createDate = const Value.absent(),
  });
  BudgetCompanion.insert({
    this.id = const Value.absent(),
    required int idCategory,
    required String categoryName,
    required int price,
    this.isNotice = const Value.absent(),
    required DateTime createDate,
  })  : idCategory = Value(idCategory),
        categoryName = Value(categoryName),
        price = Value(price),
        createDate = Value(createDate);
  static Insertable<BudgetData> custom({
    Expression<int>? id,
    Expression<int>? idCategory,
    Expression<String>? categoryName,
    Expression<int>? price,
    Expression<bool>? isNotice,
    Expression<DateTime>? createDate,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (idCategory != null) 'id_category': idCategory,
      if (categoryName != null) 'category_name': categoryName,
      if (price != null) 'price': price,
      if (isNotice != null) 'is_notice': isNotice,
      if (createDate != null) 'create_date': createDate,
    });
  }

  BudgetCompanion copyWith(
      {Value<int?>? id,
      Value<int>? idCategory,
      Value<String>? categoryName,
      Value<int>? price,
      Value<bool>? isNotice,
      Value<DateTime>? createDate}) {
    return BudgetCompanion(
      id: id ?? this.id,
      idCategory: idCategory ?? this.idCategory,
      categoryName: categoryName ?? this.categoryName,
      price: price ?? this.price,
      isNotice: isNotice ?? this.isNotice,
      createDate: createDate ?? this.createDate,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (idCategory.present) {
      map['id_category'] = Variable<int>(idCategory.value);
    }
    if (categoryName.present) {
      map['category_name'] = Variable<String>(categoryName.value);
    }
    if (price.present) {
      map['price'] = Variable<int>(price.value);
    }
    if (isNotice.present) {
      map['is_notice'] = Variable<bool>(isNotice.value);
    }
    if (createDate.present) {
      map['create_date'] = Variable<DateTime>(createDate.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('BudgetCompanion(')
          ..write('id: $id, ')
          ..write('idCategory: $idCategory, ')
          ..write('categoryName: $categoryName, ')
          ..write('price: $price, ')
          ..write('isNotice: $isNotice, ')
          ..write('createDate: $createDate')
          ..write(')'))
        .toString();
  }
}

abstract class _$DatabaseImpl extends GeneratedDatabase {
  _$DatabaseImpl(QueryExecutor e) : super(e);
  late final $UserTable user = $UserTable(this);
  late final $BankTable bank = $BankTable(this);
  late final $WalletTable wallet = $WalletTable(this);
  late final $TransactionsTable transactions = $TransactionsTable(this);
  late final $CategoryTransactionTable categoryTransaction =
      $CategoryTransactionTable(this);
  late final $TransactionTypeTable transactionType =
      $TransactionTypeTable(this);
  late final $BudgetTable budget = $BudgetTable(this);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [
        user,
        bank,
        wallet,
        transactions,
        categoryTransaction,
        transactionType,
        budget
      ];
}
