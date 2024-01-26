// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'local_data_base.dart';

// ignore_for_file: type=lint
class $CartTableTable extends CartTable
    with TableInfo<$CartTableTable, CartTableData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $CartTableTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'ID', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _productIDMeta =
      const VerificationMeta('productID');
  @override
  late final GeneratedColumn<int> productID = GeneratedColumn<int>(
      'productID', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  static const VerificationMeta _amountMeta = const VerificationMeta('amount');
  @override
  late final GeneratedColumn<int> amount = GeneratedColumn<int>(
      'amount', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns => [id, productID, amount];
  @override
  String get aliasedName => _alias ?? 'cart_table';
  @override
  String get actualTableName => 'cart_table';
  @override
  VerificationContext validateIntegrity(Insertable<CartTableData> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('ID')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['ID']!, _idMeta));
    }
    if (data.containsKey('productID')) {
      context.handle(_productIDMeta,
          productID.isAcceptableOrUnknown(data['productID']!, _productIDMeta));
    } else if (isInserting) {
      context.missing(_productIDMeta);
    }
    if (data.containsKey('amount')) {
      context.handle(_amountMeta,
          amount.isAcceptableOrUnknown(data['amount']!, _amountMeta));
    } else if (isInserting) {
      context.missing(_amountMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  CartTableData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return CartTableData(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}ID'])!,
      productID: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}productID'])!,
      amount: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}amount'])!,
    );
  }

  @override
  $CartTableTable createAlias(String alias) {
    return $CartTableTable(attachedDatabase, alias);
  }
}

class CartTableData extends DataClass implements Insertable<CartTableData> {
  final int id;
  final int productID;
  final int amount;
  const CartTableData(
      {required this.id, required this.productID, required this.amount});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['ID'] = Variable<int>(id);
    map['productID'] = Variable<int>(productID);
    map['amount'] = Variable<int>(amount);
    return map;
  }

  CartTableCompanion toCompanion(bool nullToAbsent) {
    return CartTableCompanion(
      id: Value(id),
      productID: Value(productID),
      amount: Value(amount),
    );
  }

  factory CartTableData.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return CartTableData(
      id: serializer.fromJson<int>(json['id']),
      productID: serializer.fromJson<int>(json['productID']),
      amount: serializer.fromJson<int>(json['amount']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'productID': serializer.toJson<int>(productID),
      'amount': serializer.toJson<int>(amount),
    };
  }

  CartTableData copyWith({int? id, int? productID, int? amount}) =>
      CartTableData(
        id: id ?? this.id,
        productID: productID ?? this.productID,
        amount: amount ?? this.amount,
      );
  @override
  String toString() {
    return (StringBuffer('CartTableData(')
          ..write('id: $id, ')
          ..write('productID: $productID, ')
          ..write('amount: $amount')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, productID, amount);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is CartTableData &&
          other.id == this.id &&
          other.productID == this.productID &&
          other.amount == this.amount);
}

class CartTableCompanion extends UpdateCompanion<CartTableData> {
  final Value<int> id;
  final Value<int> productID;
  final Value<int> amount;
  const CartTableCompanion({
    this.id = const Value.absent(),
    this.productID = const Value.absent(),
    this.amount = const Value.absent(),
  });
  CartTableCompanion.insert({
    this.id = const Value.absent(),
    required int productID,
    required int amount,
  })  : productID = Value(productID),
        amount = Value(amount);
  static Insertable<CartTableData> custom({
    Expression<int>? id,
    Expression<int>? productID,
    Expression<int>? amount,
  }) {
    return RawValuesInsertable({
      if (id != null) 'ID': id,
      if (productID != null) 'productID': productID,
      if (amount != null) 'amount': amount,
    });
  }

  CartTableCompanion copyWith(
      {Value<int>? id, Value<int>? productID, Value<int>? amount}) {
    return CartTableCompanion(
      id: id ?? this.id,
      productID: productID ?? this.productID,
      amount: amount ?? this.amount,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['ID'] = Variable<int>(id.value);
    }
    if (productID.present) {
      map['productID'] = Variable<int>(productID.value);
    }
    if (amount.present) {
      map['amount'] = Variable<int>(amount.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('CartTableCompanion(')
          ..write('id: $id, ')
          ..write('productID: $productID, ')
          ..write('amount: $amount')
          ..write(')'))
        .toString();
  }
}

class $DynamicVariantsTableTable extends DynamicVariantsTable
    with TableInfo<$DynamicVariantsTableTable, DynamicVariantsTableData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $DynamicVariantsTableTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'ID', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _dynamicVariantsIDMeta =
      const VerificationMeta('dynamicVariantsID');
  @override
  late final GeneratedColumn<int> dynamicVariantsID = GeneratedColumn<int>(
      'dynamicVariantsID', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  static const VerificationMeta _amountMeta = const VerificationMeta('amount');
  @override
  late final GeneratedColumn<int> amount = GeneratedColumn<int>(
      'amount', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  static const VerificationMeta _productIDMeta =
      const VerificationMeta('productID');
  @override
  late final GeneratedColumn<int> productID = GeneratedColumn<int>(
      'productID', aliasedName, true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints: GeneratedColumn.constraintIsAlways(
          'REFERENCES cart_table (productID)'));
  @override
  List<GeneratedColumn> get $columns =>
      [id, dynamicVariantsID, amount, productID];
  @override
  String get aliasedName => _alias ?? 'dynamic_variants_table';
  @override
  String get actualTableName => 'dynamic_variants_table';
  @override
  VerificationContext validateIntegrity(
      Insertable<DynamicVariantsTableData> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('ID')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['ID']!, _idMeta));
    }
    if (data.containsKey('dynamicVariantsID')) {
      context.handle(
          _dynamicVariantsIDMeta,
          dynamicVariantsID.isAcceptableOrUnknown(
              data['dynamicVariantsID']!, _dynamicVariantsIDMeta));
    } else if (isInserting) {
      context.missing(_dynamicVariantsIDMeta);
    }
    if (data.containsKey('amount')) {
      context.handle(_amountMeta,
          amount.isAcceptableOrUnknown(data['amount']!, _amountMeta));
    } else if (isInserting) {
      context.missing(_amountMeta);
    }
    if (data.containsKey('productID')) {
      context.handle(_productIDMeta,
          productID.isAcceptableOrUnknown(data['productID']!, _productIDMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  DynamicVariantsTableData map(Map<String, dynamic> data,
      {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return DynamicVariantsTableData(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}ID'])!,
      dynamicVariantsID: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}dynamicVariantsID'])!,
      amount: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}amount'])!,
      productID: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}productID']),
    );
  }

  @override
  $DynamicVariantsTableTable createAlias(String alias) {
    return $DynamicVariantsTableTable(attachedDatabase, alias);
  }
}

class DynamicVariantsTableData extends DataClass
    implements Insertable<DynamicVariantsTableData> {
  final int id;
  final int dynamicVariantsID;
  final int amount;
  final int? productID;
  const DynamicVariantsTableData(
      {required this.id,
      required this.dynamicVariantsID,
      required this.amount,
      this.productID});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['ID'] = Variable<int>(id);
    map['dynamicVariantsID'] = Variable<int>(dynamicVariantsID);
    map['amount'] = Variable<int>(amount);
    if (!nullToAbsent || productID != null) {
      map['productID'] = Variable<int>(productID);
    }
    return map;
  }

  DynamicVariantsTableCompanion toCompanion(bool nullToAbsent) {
    return DynamicVariantsTableCompanion(
      id: Value(id),
      dynamicVariantsID: Value(dynamicVariantsID),
      amount: Value(amount),
      productID: productID == null && nullToAbsent
          ? const Value.absent()
          : Value(productID),
    );
  }

  factory DynamicVariantsTableData.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return DynamicVariantsTableData(
      id: serializer.fromJson<int>(json['id']),
      dynamicVariantsID: serializer.fromJson<int>(json['dynamicVariantsID']),
      amount: serializer.fromJson<int>(json['amount']),
      productID: serializer.fromJson<int?>(json['productID']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'dynamicVariantsID': serializer.toJson<int>(dynamicVariantsID),
      'amount': serializer.toJson<int>(amount),
      'productID': serializer.toJson<int?>(productID),
    };
  }

  DynamicVariantsTableData copyWith(
          {int? id,
          int? dynamicVariantsID,
          int? amount,
          Value<int?> productID = const Value.absent()}) =>
      DynamicVariantsTableData(
        id: id ?? this.id,
        dynamicVariantsID: dynamicVariantsID ?? this.dynamicVariantsID,
        amount: amount ?? this.amount,
        productID: productID.present ? productID.value : this.productID,
      );
  @override
  String toString() {
    return (StringBuffer('DynamicVariantsTableData(')
          ..write('id: $id, ')
          ..write('dynamicVariantsID: $dynamicVariantsID, ')
          ..write('amount: $amount, ')
          ..write('productID: $productID')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, dynamicVariantsID, amount, productID);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is DynamicVariantsTableData &&
          other.id == this.id &&
          other.dynamicVariantsID == this.dynamicVariantsID &&
          other.amount == this.amount &&
          other.productID == this.productID);
}

class DynamicVariantsTableCompanion
    extends UpdateCompanion<DynamicVariantsTableData> {
  final Value<int> id;
  final Value<int> dynamicVariantsID;
  final Value<int> amount;
  final Value<int?> productID;
  const DynamicVariantsTableCompanion({
    this.id = const Value.absent(),
    this.dynamicVariantsID = const Value.absent(),
    this.amount = const Value.absent(),
    this.productID = const Value.absent(),
  });
  DynamicVariantsTableCompanion.insert({
    this.id = const Value.absent(),
    required int dynamicVariantsID,
    required int amount,
    this.productID = const Value.absent(),
  })  : dynamicVariantsID = Value(dynamicVariantsID),
        amount = Value(amount);
  static Insertable<DynamicVariantsTableData> custom({
    Expression<int>? id,
    Expression<int>? dynamicVariantsID,
    Expression<int>? amount,
    Expression<int>? productID,
  }) {
    return RawValuesInsertable({
      if (id != null) 'ID': id,
      if (dynamicVariantsID != null) 'dynamicVariantsID': dynamicVariantsID,
      if (amount != null) 'amount': amount,
      if (productID != null) 'productID': productID,
    });
  }

  DynamicVariantsTableCompanion copyWith(
      {Value<int>? id,
      Value<int>? dynamicVariantsID,
      Value<int>? amount,
      Value<int?>? productID}) {
    return DynamicVariantsTableCompanion(
      id: id ?? this.id,
      dynamicVariantsID: dynamicVariantsID ?? this.dynamicVariantsID,
      amount: amount ?? this.amount,
      productID: productID ?? this.productID,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['ID'] = Variable<int>(id.value);
    }
    if (dynamicVariantsID.present) {
      map['dynamicVariantsID'] = Variable<int>(dynamicVariantsID.value);
    }
    if (amount.present) {
      map['amount'] = Variable<int>(amount.value);
    }
    if (productID.present) {
      map['productID'] = Variable<int>(productID.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('DynamicVariantsTableCompanion(')
          ..write('id: $id, ')
          ..write('dynamicVariantsID: $dynamicVariantsID, ')
          ..write('amount: $amount, ')
          ..write('productID: $productID')
          ..write(')'))
        .toString();
  }
}

abstract class _$LocalDatabase extends GeneratedDatabase {
  _$LocalDatabase(QueryExecutor e) : super(e);
  late final $CartTableTable cartTable = $CartTableTable(this);
  late final $DynamicVariantsTableTable dynamicVariantsTable =
      $DynamicVariantsTableTable(this);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities =>
      [cartTable, dynamicVariantsTable];
}
